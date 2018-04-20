<?php

namespace App\Middlewares;

use Slim\Container;
use App\Repositories\UsuarioRepository;

final class AuthMiddleware
{
    protected $container;

    public function __construct(Container $container)
    {
        $this->container = $container;
    }

    public function __invoke($request, $response, $next)
    {
        $session = $this->container->sessionHelper->get();        
        $newResponse = $response;
       
        if (empty($session['usuario_sessao'])) {          
            header('Location: ' . $this->container->router->pathFor('login'), true, 401);
        }
        else{
            $newResponse = $next($request, $response);
        }
        
        return $newResponse;
    }
}
