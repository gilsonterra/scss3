<?php

namespace App\Controllers;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Container as Container;
use App\Repositories\AcompanhamentoRepository;
use App\Validators\AcompanhamentoValidator;

final class AcompanhamentoController extends BaseController
{
    protected $repository;
    protected $validator;

    public function __construct(Container $container, AcompanhamentoRepository $repository, AcompanhamentoValidator $validator)
    {
        parent::__construct($container);
        $this->repository = $repository;
        $this->validator = $validator;
    }

    public function fetchAll(Request $request, Response $response, $args)
    {
        $data = $request->getParams();
        $data = $this->repository->fetchAll($data, $data['paginate'], $data['page'])->toArray();
        return $this->jsonRender($response, 200, $data);
    }

    public function find(Request $request, Response $response, $args)
    {
        $data = $request->getParams();
        $data = $this->repository->findById($args['codigo'])->toArray();
        return $this->jsonRender($response, 200, $data);
    }
}
