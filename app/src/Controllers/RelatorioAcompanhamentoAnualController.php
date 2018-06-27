<?php

namespace App\Controllers;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Container as Container;
use App\Repositories\RelatorioAcompanhamentoAnualRepository;

final class RelatorioAcompanhamentoAnualController extends BaseController
{
    protected $repository;
    protected $validator;

    public function __construct(Container $container, RelatorioAcompanhamentoAnualRepository $repository)
    {
        parent::__construct($container);
        $this->repository = $repository;        
    }

    public function indexView(Request $request, Response $response, $args)
    {
        $data = $request->getParams();
        $data['grid'] = [];
        return $this->viewRender($response, 'relatorio-acompanhamento-anual/index.html', $data);
    }

    public function fetchAll(Request $request, Response $response, $args)
    {
        $data = $request->getParams();
        $data = $this->repository->fetchAll($data);
        return $this->jsonRender($response, 200, $data);
    }
}