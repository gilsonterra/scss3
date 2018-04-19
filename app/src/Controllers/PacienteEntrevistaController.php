<?php

namespace App\Controllers;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Container as Container;
use App\Repositories\PacienteEntrevistaRepository;
use App\Validators\PacienteEntrevistaValidator;

final class PacienteEntrevistaController extends BaseController
{
    protected $repository;
    protected $validator;

    public function __construct(Container $container, PacienteEntrevistaRepository $repository, PacienteEntrevistaValidator $validator)
    {
        parent::__construct($container);
        $this->repository = $repository;
        $this->validator = $validator;
    }

    public function createView(Request $request, Response $response, $args)
    {        
        $data['tipo'] = $args['tipo'];   
        $data['codigo_paciente'] = $args['codigo_paciente'];        
        return $this->viewRender($response, 'paciente/entrevista.html', $data);
    }

    public function editView(Request $request, Response $response, $args)
    {
        $data['tipo'] = $args['tipo'];   
        $data['codigo_paciente'] = $args['codigo_paciente'];        
        $data['num_doc'] = $args['num_doc'];
        return $this->viewRender($response, 'paciente/entrevista.html', $data);
    }

    public function fetchAll(Request $request, Response $response, $args)
    {
        $data = $request->getParams();
        $data = $this->repository->fetchAll($data, $data['paginate'], $data['page'])->toArray();
        return $this->jsonRender($response, 200, $data);
    }

    public function store(Request $request, Response $response, $args)
    {
        $data['dados'] = $request->getParams();
        $data['errors'] = $this->validator->valid($data['dados']);
                
        if (empty($data['errors'])) {
            if (empty($args['num_doc'])) {
                $data['message'] = $this->repository->create($data['dados']);
            } else {
                $data['message'] = $this->repository->edit($args['num_doc'], $data['dados']);
            }
        }

        return $this->jsonRender($response, 200, $data);
    }

    public function delete(Request $request, Response $response, $args)
    {        
        $data = $this->repository->delete($args['num_doc']);
        return $this->jsonRender($response, 200, $data);
    }
}
