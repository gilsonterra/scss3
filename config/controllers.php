<?php

$container['App\Controllers\SessionController'] = function ($container) {        
    return new App\Controllers\SessionController($container);
};

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

    return new App\Controllers\PacienteController($container, $repository);
};

$container['App\Controllers\MunicipioController'] = function ($container) {    
    $model = new App\Models\Municipio();    
    $repository = new App\Repositories\MunicipioRepository($model);        
    
    return new App\Controllers\MunicipioController($container, $repository);
};

$container['App\Controllers\AcompanhamentoCategoriaController'] = function ($container) {    
    $model = new App\Models\AcompanhamentoCategoria();    
    $repository = new App\Repositories\AcompanhamentoCategoriaRepository($model);        
    
    return new App\Controllers\AcompanhamentoCategoriaController($container, $repository);
};

$container['App\Controllers\PacienteIdentificacaoController'] = function ($container) {    
    $model = new App\Models\Paciente();    
    $repository = new App\Repositories\PacienteIdentificacaoRepository($model);    
    $validator = new App\Validators\PacienteIdentificacaoValidator();      
    
    return new App\Controllers\PacienteIdentificacaoController($container, $repository, $validator);
};

$container['App\Controllers\PacienteAcompanhamentoController'] = function ($container) {    
    $model = new App\Models\Acompanhamento();    
    $repository = new App\Repositories\PacienteAcompanhamentoRepository($model);    
    $validator = new App\Validators\PacienteAcompanhamentoValidator();      
    
    return new App\Controllers\PacienteAcompanhamentoController($container, $repository, $validator);
};
