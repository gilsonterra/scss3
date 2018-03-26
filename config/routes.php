<?php

use App\Middlewares\AuthMiddleware;
use App\Middlewares\AdministrativoMiddleware;

// $app->options('/{routes:.+}', function ($request, $response, $args) {
//     return $response;
// });

$app->get('/', function () {
    //return $response->withStatus(302)->withHeader('Location', 'login/entrar');
    header('Location: ' . '/login/entrar');
});

$app->group('/login', function () {
    $this->get('/entrar', 'App\Controllers\LoginController:loginView')->setName('login');
    $this->post('/login[/]', 'App\Controllers\LoginController:login');
    $this->get('/logout[/]', 'App\Controllers\LoginController:logout');
});

$app->group('/inicio', function () {
    $this->get('[/]', 'App\Controllers\InicioController:indexView')->setName('inicio');    
})->add(new AuthMiddleware($app->getContainer()));

$app->group('/local', function () {
    $this->get('/listar[/]', 'App\Controllers\LocalController:listView');
    $this->get('/criar', 'App\Controllers\LocalController:createView');
    $this->get('/editar/{codigo}', 'App\Controllers\LocalController:editView');
    $this->post('/persistir/[{codigo}]', 'App\Controllers\LocalController:store');
    $this->post('/buscar[/]', 'App\Controllers\LocalController:fetchAll');
})
->add(new AdministrativoMiddleware($app->getContainer()))
->add(new AuthMiddleware($app->getContainer()));

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

$app->group('/paciente', function () {
    $this->get('/listar[/]', 'App\Controllers\PacienteController:listView');    
    $this->get('/criar', 'App\Controllers\PacienteController:createView');    
    $this->get('/identificacao/{codigo_paciente}', 'App\Controllers\PacienteController:identificacaoView');    
    $this->get('/visualizar/{codigo_paciente}', 'App\Controllers\PacienteController:indexView')->setName('paciente.index');
    $this->post('/persistir/[{codigo_paciente}]', 'App\Controllers\PacienteController:store');
    $this->post('/buscar[/]', 'App\Controllers\PacienteController:fetchAll');
    $this->get('/importar-scac/{cod_prnt}', 'App\Controllers\PacienteController:importarSCAC');
})->add(new AuthMiddleware($app->getContainer()));

$app->group('/municipio', function () {
    $this->post('/buscar[/]', 'App\Controllers\MunicipioController:fetchAll');
})->add(new AuthMiddleware($app->getContainer()));

$app->get('/info', function () {
    phpinfo();
});
