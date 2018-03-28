<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AcompanhamentoCategoria extends Model
{
    public $timestamps    = false;
    protected $table      = "tbl_acompanhamento_categoria";
    protected $guarded    = array('codigo');
    protected $primaryKey = 'codigo';

    public function acompanhamentoItem()
    {
        return $this->hasMany('App\Models\AcompanhamentoItem', 'fk_categoria_acompanhamento')
            ->orderBy('descricao', 'ASC');
    }
}
