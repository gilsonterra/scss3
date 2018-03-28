<?php

namespace App\Repositories;

use App\Models\Paciente;

use Illuminate\Pagination\AbstractPaginator as Paginator;

final class PacienteIdentificacaoRepository extends BaseRepository
{
    /**
     * @var Paciente
     */
    protected $model;

    /**
     * Constructor
     *
     * @param Paciente $model
     */
    public function __construct(Paciente $model)
    {
        $this->model = $model;
    }

    /**
     * Criar identificação de paciente
     *
     * @param array $data
     * @return void
     */
    public function create(array $data)
    {
        try {
            $paciente = $this->model->create($data);
            $message = $this->createMessage('Paciente criado com sucesso.', 'Sucesso', BaseRepository::SUCCESS, $paciente);
        } catch (\Exception $e) {
            $message = $this->createMessage('Erro ao criar um Paciente. ' . $e->getMessage(), 'Erro', BaseRepository::ERROR);
        }

        return $message;
    }

    /**
     * Editar identificação de paciente
     *
     * @param [type] $id
     * @param array $data
     * @return void
     */
    public function edit($id, array $data)
    {
        try {
            $paciente= $this->model->findOrFail($id);
            $paciente->fill($data)->save();
            $message = $this->createMessage('Paciente alterado com sucesso.', 'Sucesso', BaseRepository::SUCCESS, $paciente);
        } catch (\Exception $e) {
            $message = $this->createMessage('Erro ao alterar o Paciente. ' . $e->getMessage(), 'Erro', BaseRepository::ERROR);
        }

        return $message;
    }
}
