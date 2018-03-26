<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AcompanhamentoCategoria extends Model
{
    public $timestamps    = false;
    protected $table      = "tbl_acompanhamento_categoria";
    protected $guarded    = array('codigo');
    protected $primaryKey = 'codigo';
}
