<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Entrevista extends Model
{
    public $timestamps    = false;
    protected $table      = "tbl_entrevista";
    protected $guarded    = array('codigo');
    protected $primaryKey = 'codigo';
    
    public function getDataCadastroAttribute($value)
    {
        $date = date_create_from_format('Y-m-d H:i:s', $value);
        return $date ? $date->format('d/m/Y') : null;
    }

    public function getTipoAttribute($value)
    {
        $descricao = '';
        switch ($value) {
            case 'C':
                $descricao = 'Criança/Adolescente';
                break;
            case 'A':
                $descricao = 'Adulto';
                break;
            case 'M':
                $descricao = 'Maternidade';
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
}
