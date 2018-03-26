<?php

namespace App\Controllers;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Container as Container;
use App\Repositories\PacienteRepository;
use App\Validators\PacienteValidator;

final class PacienteController extends BaseController
{
    protected $repository;
    protected $validator;

    public function __construct(Container $container, PacienteRepository $repository, PacienteValidator $validator)
    {
        parent::__construct($container);
        $this->repository = $repository;
        $this->validator = $validator;
    }

    public function listView(Request $request, Response $response, $args)
    {        
        return $this->viewRender($response, 'paciente/list.html');
    }

    public function importarSCAC(Request $request, Response $response, $args)
    {        
        $data = [];
        $obj = $this->repository->importarSCAC($args['cod_prnt']);                
        header('Location: ' . $this->container['router']->pathFor('paciente.index', ['codigo_paciente' => $obj['codigo_paciente']]));
        return $response;
    }

    public function indexView(Request $request, Response $response, $args)
    {
        $data['dados'] = $this->repository->findById($args['codigo_paciente'])->toArray();
        return $this->viewRender($response, 'paciente/index.html', $data);
    }

    public function identificacaoView(Request $request, Response $response, $args)
    {
        $data['dados'] = $this->repository->findById($args['codigo_paciente'])->toArray();
        return $this->viewRender($response, 'paciente/identificacao.html', $data);
    }

    public function editView(Request $request, Response $response, $args)
    {
        $data['dados'] = $this->repository->findById($args['codigo_paciente'])->toArray();
        return $this->viewRender($response, 'paciente/identificacao.html', $data);
    }

    public function createView(Request $request, Response $response, $args)
    {
        return $this->viewRender($response, 'paciente/identificacao.html');
    }

    public function store(Request $request, Response $response, $args)
    {
        $data['dados'] = $request->getParams();
        $data['errors'] = $this->validator->valid($data['dados']);

        if (empty($data['errors'])) {
            if (empty($args['codigo_paciente'])) {
                $data['message'] = $this->repository->create($data['dados']);
            } else {
                $data['message'] = $this->repository->edit($args['codigo_paciente'], $data['dados']);
            }
        }

        return $this->jsonRender($response, 200, $data);
    }

    public function fetchAll(Request $request, Response $response, $args)
    {
        $data = $request->getParams();
        $data = $this->repository->fetchAll($data, $data['paginate'], $data['page'])->toArray();
        return $this->jsonRender($response, 200, $data);
    }
}
