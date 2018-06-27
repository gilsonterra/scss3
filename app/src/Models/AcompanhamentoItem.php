<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Capsule\Manager as DB;

class AcompanhamentoItem extends Model
{
    public $timestamps    = false;
    protected $table      = "tbl_acompanhamento_item";
    protected $guarded    = array('codigo');
    protected $primaryKey = 'codigo';

    public function categoria()
    {
        return $this->belongsTo('App\Models\AcompanhamentoCategoria', 'fk_categoria_acompanhamento');
    }
}
