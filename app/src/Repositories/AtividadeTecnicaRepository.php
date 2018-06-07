<?php

namespace App\Repositories;

use App\Models\Acompanhamento;
use Illuminate\Pagination\AbstractPaginator as Paginator;

final class AtividadeTecnicaRepository extends BaseRepository
{
    /**
     * @var Acompanhamento
     */
    protected $model;

    /**
     * @var array
     */
    protected $usuarioSessao;

    /**
     * Constructor
     *
     * @param Acompanhamento $model
     */
    public function __construct(Acompanhamento $model, array $usuarioSessao)
    {
        $this->model = $model;
        $this->usuarioSessao = $usuarioSessao;
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
        $query->with('local');        
        $query->with('acompanhamentoItem.categoria');
        $query->whereRaw('codigo_paciente IS NULL');
        $query->where('fk_profissional', '=', $this->usuarioSessao['codigo']);
        $query->orderByRaw('UPPER(data_cadastro) DESC');

        // Where
        if (!empty($where['data_cadastro'])) {
            $query->whereRaw("UPPER(data_cadastro) LIKE ?", '%' . strtoupper($where['data_cadastro'] . '%'));
        }

        if (!empty($where['local'])) {
            $query->whereHas('local', function ($subQuery) use ($where) {
                $subQuery->whereRaw("UPPER(descricao) LIKE ?", '%' . strtoupper($where['local'] . '%'));
            });
        }

        if (!empty($where['categoria'])) {
            $query->whereHas('acompanhamentoItem.categoria', function ($subQuery) use ($where) {
                $subQuery->whereRaw("UPPER(descricao) LIKE ?", '%' . strtoupper($where['categoria'] . '%'));
            });
        }

        if (!empty($where['atividade'])) {
            $query->whereHas('acompanhamentoItem', function ($subQuery) use ($where) {
                $subQuery->whereRaw("UPPER(descricao) LIKE ?", '%' . strtoupper($where['atividade'] . '%'));
            });
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
        return $this->model->with('acompanhamentoItem.categoria')->findOrFail($id);
    }

    /**
     * Create
     *
     * @param array $data
     * @return void
     */
    public function create(array $data)
    {
        $message = $this->createMessage('Atividade Técnica criada com sucesso.', 'Sucesso', BaseRepository::SUCCESS);

        try {
            $this->model->create($data);
        } catch (\Exception $e) {
            $message = $this->createMessage('Erro ao criar uma Atividade Técnica.' . $e->getMessage(), 'Erro', BaseRepository::ERROR);
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
        $message = $this->createMessage('Atividade Técnica alterada com sucesso.', 'Sucesso', BaseRepository::SUCCESS);

        try {
            $query = $this->findById($id);
            $query->fill($data)->save();
        } catch (\Exception $e) {
            $message = $this->createMessage('Erro ao alterar a Atividade Técnica.' . $e->getMessage(), 'Erro', BaseRepository::ERROR);
        }

        return $message;
    }
}
