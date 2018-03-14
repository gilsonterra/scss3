<?php

namespace App\Controllers;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Container as Container;
use App\Repositories\AvisoRepository;

final class InicioController extends BaseController
{    
    public function __construct(Container $container, AvisoRepository $repository)
    {
        parent::__construct($container);
        $this->repository = $repository;
    }

    public function indexView(Request $request, Response $response, $args)
    {
        $data['status'] = 1;
        $dados['dados'] = $this->repository->fetchAll($data);
        return $this->viewRender($response, 'inicio/index.html', $dados);
    }
}
