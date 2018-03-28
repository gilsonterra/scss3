<?php

namespace App\Controllers;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Container as Container;

final class SessionController extends BaseController
{
    public function __construct(Container $container)
    {
        parent::__construct($container);        
    }

    public function get(Request $request, Response $response, $args)
    {
        $data = $this->container->sessionHelper->get();        
        return $this->jsonRender($response, 200, $data);
    }

}
