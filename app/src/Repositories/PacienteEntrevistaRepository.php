<?php

namespace App\Repositories;

use App\Models\Paciente;
use App\Models\Entrevista;

use Illuminate\Pagination\AbstractPaginator as Paginator;

final class PacienteEntrevistaRepository extends BaseRepository
{
    /**
     * @var Entrevista
     */
    protected $model;

    /**
     *
     * @var Paciente
     */
    protected $modelPaciente;

    /**
     * @param Entrevista $model
     * @param Paciente $modelPaciente
     */
    public function __construct(Entrevista $model, Paciente $modelPaciente)
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
        $query->with(['entrevistas' => function ($q) use ($where) {
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
        $message = $this->createMessage('Entrevista criada com sucesso.', 'Sucesso', BaseRepository::SUCCESS);

        try {
            $entrevista = $this->model->create($data);
            $this->_saveSituacaoFuncional($entrevista, $data['situacao_funcional']);
        } catch (\Exception $e) {
            $message = $this->createMessage('Erro ao criar uma Entrevista.' . $e->getMessage(), 'Erro', BaseRepository::ERROR);
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
        $message = $this->createMessage('Entrevista alterada com sucesso.', 'Sucesso', BaseRepository::SUCCESS);

        try {
            $entrevista = $this->model->findOrFail($id);
            $this->_saveSituacaoFuncional($entrevista, $data['situacao_funcional']);
            $entrevista->fill($data)->save();
        } catch (\Exception $e) {
            $message = $this->createMessage('Erro ao alterar o Entrevista.' . $e->getMessage(), 'Erro', BaseRepository::ERROR);
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
        $message = $this->createMessage('Entrevista excluida com sucesso.', 'Sucesso', BaseRepository::SUCCESS);

        try {
            $query = $this->model->findOrFail($id);
            $query->fill(['status' => 0])->save();
        } catch (\Exception $e) {
            $message = $this->createMessage('Erro ao excluir a Entrevista.' . $e->getMessage(), 'Erro', BaseRepository::ERROR);
        }

        return $message;
    }

    protected function _saveSituacaoFuncional($entrevistaModel, $situacaoFuncionalTipo)
    {
        $dataSituacaoFuncional = [
            'num_doc' => $entrevistaModel->num_doc,
            'tipo' => $situacaoFuncionalTipo
        ];

        $situacaoFuncional = $entrevistaModel->situacaoFuncional();
        $situacaoFuncional->delete();
        $situacaoFuncional->create($dataSituacaoFuncional);
    }
}
