<?php

namespace App\Repositories;

use App\Models\Local;

use Illuminate\Pagination\AbstractPaginator as Paginator;

final class LocalRepository extends BaseRepository
{
    /**
     * @var Local
     */
    protected $model;

    /**
     * Constructor
     *
     * @param Local $model
     */
    public function __construct(Local $model)
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
        $query->orderByRaw('UPPER(descricao) ASC');

        // Where
        if (!empty($where['descricao'])) {
            $query->whereRaw("UPPER(descricao) LIKE ?", '%' . strtoupper($where['descricao'] . '%'));
        }

        if (!empty($where['ramal'])) {
            $query->where('ramal', '=', $where['ramal']);
        }

        if (!empty($where['codigos_not_in'])) {
            $query->whereNotIn('codigo', $where['codigos_not_in']);
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
        $message = $this->createMessage('Local criado com sucesso.', 'Sucesso', BaseRepository::SUCCESS);

        try {            
            $this->model->create($data);
        } catch (\Exception $e) {
            $message = $this->createMessage('Erro ao criar um local.' . $e->getMessage(), 'Erro', BaseRepository::ERROR);
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
        $message = $this->createMessage('Local alterado com sucesso.', 'Sucesso', BaseRepository::SUCCESS);

        try {
            $query = $this->findById($id);
            $query->fill($data)->save();
        } catch (\Exception $e) {
            $message = $this->createMessage('Erro ao alterar o local.' . $e->getMessage(), 'Erro', BaseRepository::ERROR);
        }

        return $message;
    }
}
