<?php

namespace App\Repositories;

use App\Models\Acompanhamento;

use Illuminate\Pagination\AbstractPaginator as Paginator;

final class PacienteAcompanhamentoRepository extends BaseRepository
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
            $query = $this->model->findOrFail($id);
            $query->fill($data)->save();
        } catch (\Exception $e) {
            $message = $this->createMessage('Erro ao alterar o intervenção.' . $e->getMessage(), 'Erro', BaseRepository::ERROR);
        }

        return $message;
    }
}
