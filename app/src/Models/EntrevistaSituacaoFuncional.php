<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class EntrevistaSituacaoFuncional extends Model
{
    public $timestamps    = false;

    protected $table      = "tbl_ent_situacao_funcional";
    protected $guarded    = array('codigo');    
    protected $primaryKey = 'codigo';    
}
