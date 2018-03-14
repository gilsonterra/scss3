<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Municipio extends Model
{
    public $timestamps    = false;

    protected $table      = "scac.tbl_municipio_ibge";
    protected $guarded    = array('cod_ibge');    
    protected $primaryKey = 'cod_ibge';    
}
