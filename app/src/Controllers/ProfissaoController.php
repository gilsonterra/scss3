<?php

namespace App\Controllers;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Container as Container;
use App\Repositories\ProfissaoRepository;

final class ProfissaoController extends BaseController
{
    protected $repository;    

    public function __construct(Container $container, ProfissaoRepository $repository)
    {
        parent::__construct($container);
        $this->repository = $repository;
    }

    public function fetchAll(Request $request, Response $response, $args)
    {
        $data = $request->getParams();
        $data = $this->repository->fetchAll($data)->toArray();
        return $this->jsonRender($response, 200, $data);
    }
}
