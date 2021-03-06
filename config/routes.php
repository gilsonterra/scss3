<?php

use App\Middlewares\AuthMiddleware;
use App\Middlewares\AdministrativoMiddleware;

// $app->options('/{routes:.+}', function ($request, $response, $args) {
//     return $response;
// });

$app->get('/', function () {
    //return $response->withStatus(302)->withHeader('Location', 'login/entrar');
    header('Location: ' . '/login/entrar');exit;
});

$app->group('/login', function () {
    $this->get('/entrar', 'App\Controllers\LoginController:loginView')->setName('login');
    $this->post('/login[/]', 'App\Controllers\LoginController:login');
    $this->get('/logout[/]', 'App\Controllers\LoginController:logout');
});

$app->group('/inicio', function () {
    $this->get('[/]', 'App\Controllers\InicioController:indexView')->setName('inicio');    
})->add(new AuthMiddleware($app->getContainer()));

$app->group('/paciente', function () {
    $this->get('/listar[/]', 'App\Controllers\PacienteController:listView');                 
    $this->get('/visualizar/{codigo_paciente}', 'App\Controllers\PacienteController:indexView')->setName('paciente.index');    
    $this->post('/buscar[/]', 'App\Controllers\PacienteController:fetchAll');
    $this->post('/find/{codigo_paciente}', 'App\Controllers\PacienteController:find');    
    $this->get('/importar-scac/{cod_prnt}', 'App\Controllers\PacienteController:importarSCAC');

    $this->group('/identificacao', function(){
        $this->get('/criar', 'App\Controllers\PacienteIdentificacaoController:createView');
        $this->get('/editar/{codigo_paciente}', 'App\Controllers\PacienteIdentificacaoController:editView');
        $this->post('/persistir/[{codigo_paciente}]', 'App\Controllers\PacienteIdentificacaoController:store');
    });

    $this->group('/acompanhamento', function(){
        $this->get('/criar/{codigo_paciente}', 'App\Controllers\PacienteAcompanhamentoController:createView');
        $this->get('/editar/{codigo_paciente}/{codigo}', 'App\Controllers\PacienteAcompanhamentoController:editView');
        $this->post('/persistir/{codigo_paciente}[/{codigo}]', 'App\Controllers\PacienteAcompanhamentoController:store');
        $this->get('/excluir/{codigo}', 'App\Controllers\PacienteAcompanhamentoController:delete');
        $this->post('/buscar[/]', 'App\Controllers\PacienteAcompanhamentoController:fetchAll');
    });

    $this->group('/entrevista', function(){
        $this->get('/criar/{tipo}/{codigo_paciente}', 'App\Controllers\PacienteEntrevistaController:createView');
        $this->get('/editar/{tipo}/{codigo_paciente}/{num_doc}', 'App\Controllers\PacienteEntrevistaController:editView');
        $this->post('/persistir/{codigo_paciente}[/{num_doc}]', 'App\Controllers\PacienteEntrevistaController:store');
        $this->get('/excluir/{num_doc}', 'App\Controllers\PacienteEntrevistaController:delete');
        $this->post('/buscar[/]', 'App\Controllers\PacienteEntrevistaController:fetchAll');
    });
    
})->add(new AuthMiddleware($app->getContainer()));

$app->group('/acompanhamento-categoria', function () {
    $this->post('/buscar[/]', 'App\Controllers\AcompanhamentoCategoriaController:fetchAll');    
})->add(new AuthMiddleware($app->getContainer()));

$app->post('/municipio/buscar[/]', 'App\Controllers\MunicipioController:fetchAll')->add(new AuthMiddleware($app->getContainer()));

$app->group('/local', function () {
    $this->get('/listar[/]', 'App\Controllers\LocalController:listView');
    $this->get('/criar', 'App\Controllers\LocalController:createView');
    $this->get('/editar/{codigo}', 'App\Controllers\LocalController:editView');
    $this->post('/persistir/[{codigo}]', 'App\Controllers\LocalController:store');
    $this->post('/buscar[/]', 'App\Controllers\LocalController:fetchAll');
})
->add(new AdministrativoMiddleware($app->getContainer()))
->add(new AuthMiddleware($app->getContainer()));

$app->group('/profissao', function () {
    $this->get('/listar[/]', 'App\Controllers\ProfissaoController:listView');
    $this->get('/criar', 'App\Controllers\ProfissaoController:createView');
    $this->get('/editar/{codigo}', 'App\Controllers\ProfissaoController:editView');
    $this->post('/persistir/[{codigo}]', 'App\Controllers\ProfissaoController:store');    
})
->add(new AdministrativoMiddleware($app->getContainer()))
->add(new AuthMiddleware($app->getContainer()));

$app->post('/profissao/buscar[/]', 'App\Controllers\ProfissaoController:fetchAll')->add(new AuthMiddleware($app->getContainer()));

$app->group('/profissional', function () {
    $this->get('/listar[/]', 'App\Controllers\ProfissionalController:listView');
    $this->get('/criar', 'App\Controllers\ProfissionalController:createView');
    $this->get('/editar/{codigo}', 'App\Controllers\ProfissionalController:editView');
    $this->post('/persistir/[{codigo}]', 'App\Controllers\ProfissionalController:store');
    $this->post('/buscar[/]', 'App\Controllers\ProfissionalController:fetchAll');
})
->add(new AdministrativoMiddleware($app->getContainer()))
->add(new AuthMiddleware($app->getContainer()));

$app->group('/aviso', function () {
    $this->get('/listar[/]', 'App\Controllers\AvisoController:listView');
    $this->get('/criar', 'App\Controllers\AvisoController:createView');
    $this->get('/editar/{codigo}', 'App\Controllers\AvisoController:editView');
    $this->post('/persistir/[{codigo}]', 'App\Controllers\AvisoController:store');
    $this->post('/buscar[/]', 'App\Controllers\AvisoController:fetchAll');
})
->add(new AdministrativoMiddleware($app->getContainer()))
->add(new AuthMiddleware($app->getContainer()));


$app->group('/atividade-tecnica', function () {
    $this->get('/listar[/]', 'App\Controllers\AtividadeTecnicaController:listView');
    $this->get('/criar', 'App\Controllers\AtividadeTecnicaController:createView');
    $this->get('/editar/{codigo}', 'App\Controllers\AtividadeTecnicaController:editView');
    $this->post('/persistir/[{codigo}]', 'App\Controllers\AtividadeTecnicaController:store');    
    $this->post('/buscar[/]', 'App\Controllers\AtividadeTecnicaController:fetchAll');
})
->add(new AdministrativoMiddleware($app->getContainer()))
->add(new AuthMiddleware($app->getContainer()));


$app->group('/relatorio-acompanhamento-anual', function () {
    $this->get('/index[/]', 'App\Controllers\RelatorioAcompanhamentoAnualController:indexView'); 
    $this->post('/buscar[/]', 'App\Controllers\RelatorioAcompanhamentoAnualController:fetchAll');
})
->add(new AuthMiddleware($app->getContainer()));

$app->group('/relatorio-acompanhamento-mensal', function () {
    $this->get('/index[/]', 'App\Controllers\RelatorioAcompanhamentoMensalController:indexView'); 
    $this->post('/buscar[/]', 'App\Controllers\RelatorioAcompanhamentoMensalController:fetchAll');
})
->add(new AuthMiddleware($app->getContainer()));


$app->get('/info', function () {
    phpinfo();
});
