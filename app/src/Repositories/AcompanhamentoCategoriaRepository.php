<?php

namespace App\Repositories;

use App\Models\AcompanhamentoCategoria;

final class AcompanhamentoCategoriaRepository extends BaseRepository
{
    
    /**
     * @var AcompanhamentoCategoria
     */
    protected $model;

    /**
     * Constructor
     *
     * @param Municipio $model
     */
    public function __construct(AcompanhamentoCategoria $model)
    {
        $this->model = $model;
    }

    /**
     * Busca Municipio
     *
     * @param array $where
     * @param boolean $paginate
     * @param integer $page
     * @return void
     */
    public function fetchAll(array $where = array(), $paginate = false, $page = 1)
    {
        $query = $this->model->newQuery();      
        $query->with('acompanhamentoItem');  
        $query->orderBy('descricao', 'ASC');

        // Where
        if (!empty($where['codigo'])) {
            $query->where('codigo', '=', $where['codigo']);
        }

        if (!empty($where['tipo'])) {
            $query->where('tipo', '=', $where['tipo']);
        }
        
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
            $message = $this->createMessage('Erro ao alterar a Intervenção.' . $e->getMessage(), 'Erro', BaseRepository::ERROR);
        }

        return $message;
    }
}
