<?php

namespace App\Repositories;

use App\Models\Paciente;
use App\Models\Acompanhamento;

use Illuminate\Pagination\AbstractPaginator as Paginator;

final class PacienteAcompanhamentoRepository extends BaseRepository
{
    /**
     * @var Acompanhamento
     */
    protected $model;

    /**
     *
     * @var Paciente
     */
    protected $modelPaciente;

    /**
     * @param Acompanhamento $model
     * @param Paciente $modelPaciente
     */
    public function __construct(Acompanhamento $model, Paciente $modelPaciente)
    {
        $this->model = $model;
        $this->modelPaciente = $modelPaciente;
    }

    /**
     * Undocumented function
     *
     * @return void
     */
    public function fetchAll(array $where = array())
    {
        $query = $this->modelPaciente->newQuery();
        $query->with(['acompanhamentos' => function ($q) use ($where) {
            if (!empty($where['codigo'])) {
                $q->where('codigo', '=', $where['codigo']);
            }
        }]);

        // Where
        if (!empty($where['codigo_paciente'])) {
            $query->where('codigo_paciente', '=', $where['codigo_paciente']);
        }

        return $query->first();
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

    /**
     * Excluir (inativa) o registro
     *
     * @param [type] $id
     * @return void
     */
    public function delete($id)
    {
        $message = $this->createMessage('Intervenção excluida com sucesso.', 'Sucesso', BaseRepository::SUCCESS);

        try {
            $query = $this->model->findOrFail($id);
            $query->fill(['status' => 0])->save();
        } catch (\Exception $e) {
            $message = $this->createMessage('Erro ao excluir a intervenção.' . $e->getMessage(), 'Erro', BaseRepository::ERROR);
        }

        return $message;
    }
}
