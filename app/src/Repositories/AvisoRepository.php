<?php

namespace App\Repositories;

use App\Models\Aviso;

final class AvisoRepository extends BaseRepository
{
    
    /**
     * @var Aviso
     */
    protected $model;

    /**
     * Constructor
     *
     * @param Aviso $model
     */
    public function __construct(Aviso $model)
    {
        $this->model = $model;
    }

    /**
     * FetchAll 
     *
     * @param array $where
     * @param boolean $paginate
     * @return void
     */
    public function fetchAll(array $where = array(), $paginate = false, $page = 1)
    {
        $query = $this->model->newQuery();
        $query->orderBy('codigo', 'DESC');        

        
        // Where
        if (!empty($where['codigo'])) {
            $query->where('codigo', '=', $where['codigo']);
        }

        if (!empty($where['aviso'])) {
            $query->where('aviso', 'LIKE', '%' . strtoupper($where['aviso']) . '%');
        } 
        
        if (isset($where['status'])) {
            $query->where('status', '=', $where['status']);
        } 

        if ($paginate) {
            $data = $this->paginate($query, $page);
        } else {
            $data = $query->get();
        }

        return $data;
    }

    public function findById($id)
    {
        return $this->model->findOrFail($id);
    }

    public function create(array $data){
        $message = $this->createMessage('Aviso criado com sucesso.', 'Sucesso', BaseRepository::SUCCESS);        

        try {            
            $this->model->create($data);
        }
        catch(\Exception $e){ 
            $message = $this->createMessage('Erro ao criar um Aviso.' . $e->getMessage(), 'Erro', BaseRepository::ERROR);
        }

        return $message;
    }

    public function edit($id, array $data){
        
        $message = $this->createMessage('Aviso alterado com sucesso.', 'Sucesso', BaseRepository::SUCCESS);

        try {
            $query = $this->findById($id);
            $query->fill($data)->save();
        }
        catch(\Exception $e){
            $message = $this->createMessage('Erro ao alterar o Aviso.' . $e->getMessage(), 'Erro', BaseRepository::ERROR);
        }

        return $message;
    }
}
