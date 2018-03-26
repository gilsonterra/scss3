<?php

namespace App\Repositories;


use App\Models\Paciente;
use App\Models\ViewPaciente;


final class PacienteRepository extends BaseRepository
{
    
    /**
     * @var Paciente
     */
    protected $modelPaciente;

    /**           
     * @var ViewPaciente
     */
    protected $modelViewPaciente;

    /**
     * Construtor
     *
     * @param Paciente $modelPaciente
     * @param ViewPaciente $modelViewPaciente
     */
    public function __construct(Paciente $modelPaciente, ViewPaciente $modelViewPaciente)
    {
        $this->modelPaciente = $modelPaciente;
        $this->modelViewPaciente = $modelViewPaciente;
    }

    /**
     * Find by Id
     *
     * @param int $id
     * @return void
     */
    public function findById($id)
    {
        return $this->modelPaciente
            ->with('endereco')
            ->with('enderecoContato')
            ->with('acompanhamentos.local')
            ->with('acompanhamentos.profissional')
            ->with('acompanhamentos.acompanhamentoItem.categoria')
            ->with('entrevistas.local')
            ->with('entrevistas.profissional')
            ->findOrFail($id);
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
        $query = $this->modelViewPaciente->newQuery();        
        $query->orderBy('tipo', 'DESC');

        // Where
        if (!empty($where['codigo_paciente'])) {
            $query->where('codigo_paciente', '=', $where['codigo_paciente']);
        }

        if (!empty($where['cod_prnt'])) {
            $query->where('cod_prnt', '=', $where['cod_prnt']);
        }
        
        if (!empty($where['nome_pac'])) {
            $query->whereRaw("UPPER(nome_pac) LIKE ?", '%' . strtoupper($where['nome_pac'] . '%'));
        }

        if (!empty($where['nome_mae_pac'])) {
            $query->whereRaw("UPPER(nome_mae_pac) LIKE ?", '%' . strtoupper($where['nome_mae_pac'] . '%'));
        }

        if (!empty($where['nome_social'])) {
            $query->whereRaw("UPPER(nome_social) LIKE ?", '%' . strtoupper($where['nome_social'] . '%'));
        }

        if (!empty($where['data_nasc_pac'])) {
            $query->whereRaw("UPPER(data_nasc_pac) LIKE ?", '%' . strtoupper($where['data_nasc_pac'] . '%'));
        }

        if ($paginate) {
            $data = $this->paginate($query, $page);
        } else {
            $data = $query->get();
        }

        return $data;
    }

    public function create(array $data)
    {
        $message = $this->createMessage('Paciente criado com sucesso.', 'Sucesso', BaseRepository::SUCCESS);

        try {            
            $this->modelPaciente->create($data);
        } catch (\Exception $e) {
            $message = $this->createMessage('Erro ao criar um Paciente. ' . $e->getMessage(), 'Erro', BaseRepository::ERROR);
        }

        return $message;
    }

    public function edit($id, array $data)
    {
        $message = $this->createMessage('Paciente alterado com sucesso.', 'Sucesso', BaseRepository::SUCCESS);

        try {
            $query = $this->findByID($id);
            $query->fill($data)->save();
        } catch (\Exception $e) {
            $message = $this->createMessage('Erro ao alterar o Paciente. ' . $e->getMessage(), 'Erro', BaseRepository::ERROR);
        }

        return $message;
    }

    public function importarSCAC($codPrnt)
    {
        $pacienteSCAC = new ViewPaciente();
        $paciente = new Paciente();
        $queryPaciente = $paciente->newQuery();

        $importado = $queryPaciente->where('cod_prnt', '=', $codPrnt)->first();
        if (!$importado) {            
            $dadosSCAC = $pacienteSCAC->find($codPrnt)->toArray();            
            $paciente->fill($dadosSCAC)->save();
        }
        else{
            $paciente = $importado;
        }

        return $paciente;
    }
}
