<?php

namespace App\Repositories;

use App\Models\Acompanhamento;

use Illuminate\Pagination\AbstractPaginator as Paginator;

final class AcompanhamentoRepository extends BaseRepository
{
    /**
     * @var Local
     */
    protected $model;

    /**
     * Constructor
     *
     * @param Acompanhamento $model
     */
    public function __construct(Acompanhamento $model)
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

        // Where
        if (!empty($where['codigo_paciente'])) {
            $query->where('codigo_paciente', '=', $where['codigo_paciente']);
        }

        if (!empty($where['codigo'])) {
            $query->where('codigo', '=', $where['codigo']);
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
        $message = $this->createMessage('Intervenção criado com sucesso.', 'Sucesso', BaseRepository::SUCCESS);

        try {            
            $this->model->create($data);
        } catch (\Exception $e) {
            $message = $this->createMessage('Erro ao criar uma Intervenção.' . $e->getMessage(), 'Erro', BaseRepository::ERROR);
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
        $message = $this->createMessage('Intervenção alterado com sucesso.', 'Sucesso', BaseRepository::SUCCESS);

        try {
            $query = $this->findById($id);
            $query->fill($data)->save();
        } catch (\Exception $e) {
            $message = $this->createMessage('Erro ao alterar o intervenção.' . $e->getMessage(), 'Erro', BaseRepository::ERROR);
        }

        return $message;
    }
}
