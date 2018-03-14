<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Aviso extends Model
{
    public $timestamps    = false;

    protected $table      = "tbl_aviso";
    protected $guarded    = array('codigo');    
    protected $primaryKey = 'codigo';    
}
