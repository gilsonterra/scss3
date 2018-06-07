<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Profissional extends Model
{
    public $timestamps    = false;

    protected $table      = "tbl_profissional";
    protected $guarded    = array('codigo');    
    protected $primaryKey = 'codigo';    
    protected $fillable   = ['nome', 'login', 'senha', 'ativo', 'perfil'];

    public function locais(){
        return $this->belongsToMany('App\Models\Local', 'tbl_prof_x_local', 'cod_profissional', 'cod_local')
            ->where('tbl_prof_x_local.status', '=', 1);
    }
}
