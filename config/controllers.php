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
    $modelPaciente = new App\Models\Paciente();    
    $repository = new App\Repositories\PacienteAcompanhamentoRepository($model, $modelPaciente);    
    $validator = new App\Validators\PacienteAcompanhamentoValidator();      
    
    return new App\Controllers\PacienteAcompanhamentoController($container, $repository, $validator);
};

$container['App\Controllers\PacienteEntrevistaController'] = function ($container) {    
    $model = new App\Models\Entrevista();    
    $modelPaciente = new App\Models\Paciente();    
    $repository = new App\Repositories\PacienteEntrevistaRepository($model, $modelPaciente);    
    $validator = new App\Validators\PacienteEntrevistaValidator();      
    
    return new App\Controllers\PacienteEntrevistaController($container, $repository, $validator);
};

$container['App\Controllers\ProfissaoController'] = function ($container) {    
    $model = new App\Models\Profissao();    
    $repository = new App\Repositories\ProfissaoRepository($model); 
    $validator = new App\Validators\ProfissaoValidator();                

    return new App\Controllers\ProfissaoController($container, $repository, $validator);
};

$container['App\Controllers\AtividadeTecnicaController'] = function ($container) {    
    $model = new App\Models\Acompanhamento();    
    $session = $container->sessionHelper->get();    
    $repository = new App\Repositories\AtividadeTecnicaRepository($model, $session['usuario_sessao']);    
    $validator = new App\Validators\AtividadeTecnicaValidator();      
    
    return new App\Controllers\AtividadeTecnicaController($container, $repository, $validator);
};

$container['App\Controllers\RelatorioAcompanhamentoAnualController'] = function ($container) {    
    $model = new App\Models\ViewRelAnalitico();  
    $modelItem = new App\Models\AcompanhamentoItem();  
    $repository = new App\Repositories\RelatorioAcompanhamentoAnualRepository($model, $modelItem);        
    
    return new App\Controllers\RelatorioAcompanhamentoAnualController($container, $repository);
};


