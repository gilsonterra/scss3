<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Profissao extends Model
{
    public $timestamps    = false;

    protected $table      = "tbl_profissao";
    protected $guarded    = array('codigo');    
    protected $primaryKey = 'codigo';    
}
