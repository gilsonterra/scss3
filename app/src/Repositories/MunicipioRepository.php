<?php

namespace App\Repositories;

use App\Models\Municipio;

final class MunicipioRepository extends BaseRepository
{
    
    /**
     * @var Municipio
     */
    protected $model;

    /**
     * Constructor
     *
     * @param Municipio $model
     */
    public function __construct(Municipio $model)
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
        $query->orderBy('nome_municipio', 'ASC');

        // Where
        if (!empty($where['uf_municipio'])) {
            $query->where('uf_municipio', '=', $where['uf_municipio']);
        }

        if (!empty($where['cod_ibge'])) {
            $query->where('cod_ibge', '=', $where['cod_ibge']);
        }
        
        if ($paginate) {
            $data = $this->paginate($query, $page);
        } else {
            $data = $query->get();
        }

        return $data;
    }
}
