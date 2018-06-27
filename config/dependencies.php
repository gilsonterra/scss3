<?php

/**
 * DATA BASE
 */
use Yajra\Oci8\Oci8Connection;
use Illuminate\Database\Capsule\Manager as Capsule;
use Yajra\Oci8\Connectors\OracleConnector;

$capsule = new Capsule();
$capsule->addConnection($container->get('settings')['db']);
$capsule->bootEloquent();
$capsule->setAsGlobal();
$capsule->getDatabaseManager()->extend('oracle', function ($config) {
    $connector = new OracleConnector();
    $connection = $connector->connect($config);
    $db = new Oci8Connection($connection, $config['database'], $config['prefix']);
    $db->setDateFormat('YYYY-MM-DD HH24:MI:SS');
    return $db;
});

/**
  * TWIG (VIEW)
  */
 $container['view'] = function ($c) {
     $settings = $c->get('settings');
     $view     = new \Slim\Views\Twig($settings['view']['template_path'], $settings['view']['twig']);
     $view->addExtension(new Slim\Views\TwigExtension($c->get('router'), $c->get('request')->getUri()));
     $view->addExtension(new Twig_Extension_Debug());
     $view->getEnvironment()->addGlobal('current_router', $c->get('request')->getUri()->getPath());


     $session = $c->sessionHelper->get();
     if (!empty($session['usuario_sessao'])) {
         $view->getEnvironment()->addGlobal('usuario_sessao', $session['usuario_sessao']);
     }
     return $view;
 };

/**
 * PAGE NOT FOUND (404)
 */
$container['notFoundHandler'] = function ($c) {
    return function ($request, $response) use ($c) {
        if ($request->isXhr()) {
            return $c['response']->withStatus(404)->withHeader('Content-Type', 'text/json')->write(json_encode('Página não encontrada!'));
        } else {
            return $c['view']->render($response, '400.html', []);
        }
    };
};
/**
 * PAGE NOT ALLOWED (405)
 */
$container['notAllowedHandler'] = function ($c) {
    return function ($request, $response, $methods) use ($c) {        
        return $c['response']
            ->withStatus(405)
            ->withHeader('Allow', implode(', ', $methods))
            ->withHeader('Content-type', 'text/html')
            ->write('O metodo deve ser: ' . implode(', ', $methods));
    };
};

/**
 * PAGE ERROR (500)
 */
$container['errorHandler'] = function ($c) {
    return function (Slim\Http\Request $request, $response, $exception) use ($c) {        
        if ($request->isXhr()) {
            $dados = [
                'title' => 'Erro',
                'html'  => 'Ocorreu um erro inesperado. <br /> <code>' . $exception->getMessage() . '</code>',
                'type'  => 'error'
            ];
            
            return $c['response']->withStatus(500)->withHeader('Content-Type', 'text/json')->write(json_encode($dados));
        } else {            
            return $c['view']->render($response, '500.html', [
                'message' => $exception->getMessage(),
                'file' => $exception->getFile(),
                'line' => $exception->getLine(),
            ]);
        }
    };
};

$container['phpErrorHandler'] = function ($c) {        
    return function (Slim\Http\Request $request, $response, $exception) use ($c) {
        if ($request->isXhr()) {
            $dados = [
                'title' => 'Erro',
                'html'  => 'PHP FATAL ERROR: <br /> <code>' . $exception->getMessage() . '</code>',
                'type'  => 'error'
            ];
            
            return $c['response']->withStatus(500)->withHeader('Content-Type', 'text/json')->write(json_encode($dados));
        } else {
            //var_dump($exception);exit;
            return $c['view']->render($response, '500.html', [
                'message' => 'PHP FATAL ERROR: ' . $exception->getMessage(),
                'file' => $exception->getFile(),
                'line' => $exception->getLine(),
            ]);
        }
    };
};


$container['sessionHelper'] = function ($c) {
    return new App\Helpers\SessionHelper();
};
