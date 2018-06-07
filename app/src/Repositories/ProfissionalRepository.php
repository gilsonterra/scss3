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
        $query->orderByRaw('UPPER(nome) ASC');

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
        $pdo = DB::getPdo();
        $message = $this->createMessage('Profissional criado com sucesso.', 'Sucesso', BaseRepository::SUCCESS);

        if (empty($data['senha'])) {
            unset($data['senha']);
        }

        try {
            $pdo->beginTransaction();
            $locaisInstance = $this->getLocaisInstances($data['locais']);
            
            $profissional = $this->model->create($data);
            $profissional->locais()->saveMany($locaisInstance);
            
            $pdo->commit();
        } catch (\Exception $e) {
            $pdo->rollBack();
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
        $pdo = DB::getPdo();
        $message = $this->createMessage('Profissional alterado com sucesso.', 'Sucesso', BaseRepository::SUCCESS);

        if (empty($data['senha'])) {
            unset($data['senha']);
        }

        try {
            $pdo->beginTransaction();

            $profissional = $this->model->findOrFail($id);
            $profissional->fill($data)->save();
            
            // Delete all
            DB::table('tbl_prof_x_local')->where('cod_profissional', '=', $id)->update(['status' => 0]);

            if (!empty($data['locais'])) {
                if (is_array($data['locais'])) {
                    foreach ($data['locais'] as $localId) {
                        $count = DB::table('tbl_prof_x_local')
                                ->where('cod_profissional', '=', $id)
                                ->where('cod_local', '=', $localId)
                                ->count();

                        if ($count > 0) {
                            DB::table('tbl_prof_x_local')
                                ->where('cod_profissional', '=', $id)
                                ->where('cod_local', '=', $localId)
                                ->update(['status' => 1]);
                        } else {
                            DB::table('tbl_prof_x_local')->insert(['status' => 1, 'cod_local' => $localId, 'cod_profissional' => $id]);
                        }
                    }
                }
            }

            $pdo->commit();
        } catch (\Exception $e) {
            $pdo->rollBack();
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
    protected function getLocaisInstances($locais)
    {
        $locaisInstance = [];

        if (!empty($locais)) {
            if (is_array($locais)) {
                foreach ($locais as $local) {
                    array_push($locaisInstance, $this->modelLocal->findOrFail($local));
                }
            } else {
                array_push($locaisInstance, $this->modelLocal->findOrFail($locais));
            }
        }

        return $locaisInstance;
    }

    
}
