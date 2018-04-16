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
     * Find by id
     *
     * @param int $id
     * @return void
     */
    public function findById($id)
    {
        return $this->model->findOrFail($id);
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

        if ($paginate) {
            $data = $this->paginate($query, $page);
        } else {
            $data = $query->get();
        }

        return $data;
    }
}
