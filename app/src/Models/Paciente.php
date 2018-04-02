<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Paciente extends Model
{
    const CREATED_AT = 'data_cadastro';
    const UPDATED_AT = 'data_alteracao';

    protected $table      = "tbl_paciente";
    protected $guarded    = array('codigo_paciente');
    protected $primaryKey = 'codigo_paciente';
    protected $fillable   = [
        'acompanhante',
        'cns',
        'cod_muni_ibge',
        'cod_muni_ibge_cont',
        'cod_prnt',
        'end_pac',
        'end_pac_contato',
        'data_nasc_pac',
        'fk_profissional',
        'fone_pac',
        'fone_pac_2',
        'fone_pac_2_nome',
        'fone_pac_3',
        'fone_pac_3_nome',
        'fone_pac_4',
        'fone_pac_4_nome',
        'fone_pac_nome',
        'grau_parentesco_acomp',
        'nome_mae_pac',
        'nome_pac',
        'nome_pai_pac',
        'nome_social',
        'observacoes',
        'procedencia',
        'sexo_pac'
    ];

    public function getDataCadastroAttribute($value)
    {
        $date = date_create_from_format('Y-m-d H:i:s', $value);
        return $date ? $date->format('d/m/Y H:i') : null;
    }

    public function getDataAlteracaoAttribute($value)
    {
        $date = date_create_from_format('Y-m-d H:i:s', $value);
        return $date ? $date->format('d/m/Y H:i') : null;
    }

    public function getDataNascPacAttribute($value)
    {
        $date = date_create_from_format('Y-m-d H:i:s', $value);
        return $date ? $date->format('d/m/Y') : null;
    }

    public function setDataNascPacAttribute($value)
    { 
        $date = date_create_from_format('d/m/Y', $value);
        $this->attributes['data_nasc_pac'] = $date->format('Y-m-d');
    }

    public function endereco()
    {
        return $this->hasOne('App\Models\Municipio', 'cod_ibge', 'cod_muni_ibge');
    }

    public function enderecoContato()
    {
        return $this->hasOne('App\Models\Municipio', 'cod_ibge', 'cod_muni_ibge_cont');
    }

    public function profissional()
    {
        return $this->hasOne('App\Models\Profissional', 'codigo', 'fk_profissional');
    }

    public function acompanhamentos()
    {
        return $this->hasMany('App\Models\Acompanhamento', 'codigo_paciente', 'codigo_paciente')
            ->where('status', '=', 1)
            ->orderBy('data_cadastro', 'DESC');
    }

    public function entrevistas()
    {
        return $this->hasMany('App\Models\Entrevista', 'codigo_paciente', 'codigo_paciente')
            ->where('status', '=', 1)
            ->orderBy('data_cadastro', 'DESC');
    }
}
