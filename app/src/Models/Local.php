<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Local extends Model
{
    public $timestamps    = false;
    protected $table      = "tbl_local";
    protected $guarded    = array('codigo');    
    protected $primaryKey = 'codigo';    
}
