<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Entrevista extends Model
{
    public $timestamps    = false;
    protected $table      = "tbl_entrevista";
    protected $guarded    = array('num_doc', 'profissao');
    protected $primaryKey = 'num_doc';
    protected $appends = array('tipo_descricao');
    
    public function getDataCadastroAttribute($value)
    {
        $date = date_create_from_format('Y-m-d H:i:s', $value);
        return $date ? $date->format('d/m/Y') : null;
    }

    public function setDataCadastroAttribute($value)
    {
        $date = date_create_from_format('d/m/Y', $value);        
        $this->attributes['data_cadastro'] = $date->format('Y-m-d');
    }

    public function getTipoDescricaoAttribute($value)
    {        
        $descricao = '';
        switch ($this->tipo) {
            case 'C':
                $descricao = 'CRIANÇA E ADOLESCENTE';
                break;
            case 'CM':
                $descricao = 'CRIANÇA E ADOLESCENTE / MATERNIDADE';
                break;
            case 'A':
                $descricao = 'ADULTO';
                break;
            case 'M':
                $descricao = 'ADULTO / MATERNIDADE';
                break;
            case 'CP':
                $descricao = 'ADULTO / CUIDADOS PALEATIVOS';
                break;
        }
        return $descricao;
    }

    public function local()
    {
        return $this->hasOne('App\Models\Local', 'codigo', 'fk_local');
    }

    public function profissional()
    {
        return $this->hasOne('App\Models\Profissional', 'codigo', 'fk_profissional');
    }

    public function profissao()
    {
        return $this->hasOne('App\Models\Profissao', 'codigo', 'fk_profissao');
    }

    public function situacaoFuncional()
    {
        return $this->hasMany('App\Models\EntrevistaSituacaoFuncional', 'num_doc', 'num_doc');
    }
}
