<?php

$container['App\Controllers\LoginController'] = function ($container) {
    $model = new App\Models\Profissional();    
    $validator = new App\Validators\LoginValidator();
    $repository = new App\Repositories\ProfissionalRepository($model);    
    return new App\Controllers\LoginController($container, $repository, $validator);
};

$container['App\Controllers\InicioController'] = function ($container) {
    $model = new App\Models\Aviso();    
    $repository = new App\Repositories\AvisoRepository($model);    
    return new App\Controllers\InicioController($container, $repository);
};

$container['App\Controllers\LocalController'] = function ($container) {    
    $model = new App\Models\Local();
    $repository = new App\Repositories\LocalRepository($model);    
    $validator = new App\Validators\LocalValidator();

    return new App\Controllers\LocalController($container, $repository, $validator);
};

$container['App\Controllers\ProfissionalController'] = function ($container) {  
    $modelProfissional = new App\Models\Profissional();
    $modelLocal = new App\Models\Local();  
    $repository = new App\Repositories\ProfissionalRepository($modelProfissional, $modelLocal);    
    $validator = new App\Validators\ProfissionalValidator();

    return new App\Controllers\ProfissionalController($container, $repository, $validator);
};

$container['App\Controllers\AvisoController'] = function ($container) {    
    $model = new App\Models\Aviso();    
    $repository = new App\Repositories\AvisoRepository($model);    
    $validator = new App\Validators\AvisoValidator();

    return new App\Controllers\AvisoController($container, $repository, $validator);
};

$container['App\Controllers\PacienteController'] = function ($container) {    
    $modelPaciente = new App\Models\Paciente();    
    $modelViewPaciente = new App\Models\ViewPaciente();    
    $repository = new App\Repositories\PacienteRepository($modelPaciente, $modelViewPaciente);    
    $validator = new App\Validators\PacienteValidator();

    return new App\Controllers\PacienteController($container, $repository, $validator);
};

$container['App\Controllers\MunicipioController'] = function ($container) {    
    $model = new App\Models\Municipio();    
    $repository = new App\Repositories\MunicipioRepository($model);        
    
    return new App\Controllers\MunicipioController($container, $repository);
};
