<?php

namespace App\Repositories;

use App\Models\Profissao;
use Illuminate\Database\Capsule\Manager as DB;

final class ProfissaoRepository extends BaseRepository
{
    /**
     * @var Profissao
     */
    protected $model;

    /**
     * Constructor
     *
     * @param Profissao $model
     */
    public function __construct(Profissao $model)
    {
        $this->model = $model;
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
        $query->orderByRaw('UPPER(descricao)', 'asc');

        // Where
        if (!empty($where['descricao'])) {
            $query->whereRaw("UPPER(descricao) LIKE ?", '%' . strtoupper($where['descricao'] . '%'));
        }

        $query->where('status', '=', ($where['status'] === '0') ? '0' : '1');

        if ($paginate) {
            $data = $this->paginate($query, $page);
        } else {
            $data = $query->get();
        }

        return $data;
    }

    /**
     * Find by Id
     *
     * @param int $id
     * @return void
     */
    public function findById($id)
    {
        return $this->model->findOrFail($id);
    }

    /**
     * Create
     *
     * @param array $data
     * @return void
     */
    public function create(array $data)
    {
        $message = $this->createMessage('Profissão criado com sucesso.', 'Sucesso', BaseRepository::SUCCESS);

        try {            
            $this->model->create($data);
        } catch (\Exception $e) {
            $message = $this->createMessage('Erro ao criar uma profissão.' . $e->getMessage(), 'Erro', BaseRepository::ERROR);
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
        $message = $this->createMessage('Profissão alterada com sucesso.', 'Sucesso', BaseRepository::SUCCESS);

        try {
            $query = $this->findById($id);
            $query->fill($data)->save();
        } catch (\Exception $e) {
            $message = $this->createMessage('Erro ao alterar a profissão.' . $e->getMessage(), 'Erro', BaseRepository::ERROR);
        }

        return $message;
    }
}
