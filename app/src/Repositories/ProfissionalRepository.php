<?php

namespace App\Repositories;

use App\Models\Profissional;
use App\Models\Local;
use Illuminate\Database\Capsule\Manager as DB;

final class ProfissionalRepository extends BaseRepository
{
    /**
     * @var Profissional
     */
    protected $model;

    /**          
     * @var Local
     */
    protected $modelLocal;

    /**
     * Constructor
     *
     * @param Profissional $model
     */
    public function __construct(Profissional $model, Local $modelLocal = null)
    {
        $this->model = $model;
        $this->modelLocal = $modelLocal;
    }

    /**
     * Find by id
     *
     * @param int $id
     * @return void
     */
    public function findById($id)
    {
        return $this->model->with(array('locais' => function ($query) {
            $query->orderBy('descricao', 'ASC');
        }))->findOrFail($id);
    }

    /**
     * Fetch All
     *
     * @param array $where
     * @param boolean $paginate
     * @param integer $page
     * @return void
     */
    public function fetchAll(array $where = array(), $paginate = false, $page = 1)
    {
        $query = $this->model->newQuery();
        $query->with('locais');
        $query->orderByRaw('UPPER(nome)', 'asc');

        // Where
        if (!empty($where['nome'])) {
            $query->whereRaw("UPPER(nome) LIKE ?", '%' . strtoupper($where['nome'] . '%'));
        }

        if (!empty($where['login'])) {            
            $query->whereRaw("UPPER(login) LIKE ?", '%' . strtoupper($where['login'] . '%'));
        }

        if (!empty($where['senha'])) {            
            $query->where('senha', '=', $where['senha']);
        }

        if ($where['admin'] != '') {
            $query->where('admin', '=', $where['admin']);
        }

        if (!empty($where['perfil'])) {
            $query->where('perfil', '=', $where['perfil']);
        }

        $query->where('ativo', '=', ($where['ativo'] === '0') ? '0' : '1');

        if ($paginate) {
            $data = $this->paginate($query, $page);
        } else {
            $data = $query->get();
        }

        return $data;
    }

    /**
     * Create
     *
     * @param array $data
     * @return void
     */
    public function create(array $data)
    {        
        $message = $this->createMessage('Profissional criado com sucesso.', 'Sucesso', BaseRepository::SUCCESS);

        try {
            DB::getPdo()->beginTransaction();
            $locaisInstance = $this->getLocaisInstances($data['locais']);
            
            $profissional = $this->model->create($data);
            $profissional->locais()->saveMany($locaisInstance);
            
            DB::getPdo()->commit();
        } catch (\Exception $e) {
            DB::getPdo()->rollBack();
            $message = $this->createMessage('Erro ao criar um Profissional.' . $e->getMessage(), 'Erro', BaseRepository::ERROR);
        }

        return $message;
    }

    /**
     * Edit
     *
     * @param [type] $id
     * @param array $data
     * @return void
     */
    public function edit($id, array $data)
    {
        $message = $this->createMessage('Profissional alterado com sucesso.', 'Sucesso', BaseRepository::SUCCESS);        
        try {
            DB::getPdo()->beginTransaction();
            $locaisInstance = $this->getLocaisInstances($data['locais']);

            $profissional = $this->model->findOrFail($id);
            $profissional->locais()->detach();
            $profissional->fill($data)->save();
            $profissional->locais()->saveMany($locaisInstance);

            DB::getPdo()->commit();
        } catch (\Exception $e) {
            DB::getPdo()->rollBack();
            $message = $this->createMessage('Erro ao alterar o Profissional.' . $e->getMessage(), 'Erro', BaseRepository::ERROR);
        }

        return $message;
    }

    /**
     * get Locais
     *
     * @param array $locais
     * @return void
     */
    protected function getLocaisInstances(array $locais)
    {
        $locaisInstance = [];
        foreach ($locais as $local) {
            array_push($locaisInstance, $this->modelLocal->findOrFail($local['codigo']));
        }
        return $locaisInstance;
    }
}
