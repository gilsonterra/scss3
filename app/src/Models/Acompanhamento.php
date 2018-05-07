<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Acompanhamento extends Model
{
    public $timestamps    = false;
    protected $table      = "tbl_acompanhamento";
    protected $guarded    = array('codigo');
    protected $primaryKey = 'codigo';
    protected $appends = array('somente_visualizar');

    public function getSomenteVisualizarAttribute($value)
    {                        
        $objectDataCadastro = date_create_from_format('d/m/Y', $this->data_cadastro);        
        $diff = date_diff(new \DateTime(), $objectDataCadastro );        
        return $diff->format('%a') > 7;
    }
    
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

    public function local()
    {
        return $this->hasOne('App\Models\Local', 'codigo', 'fk_local');
    }

    public function profissional()
    {
        return $this->hasOne('App\Models\Profissional', 'codigo', 'fk_profissional');
    }

    public function acompanhamentoItem()
    {
        return $this->hasOne('App\Models\AcompanhamentoItem', 'codigo', 'fk_acompanhamento');
    }

    public function paciente()
    {
        return $this->belongsTo('App\Models\Paciente', 'codigo_paciente', 'codigo_paciente');
    }
}
