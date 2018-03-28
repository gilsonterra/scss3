<?php

namespace App\Controllers;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Container as Container;
use App\Repositories\PacienteIdentificacaoRepository;
use App\Validators\PacienteIdentificacaoValidator;

final class PacienteIdentificacaoController extends BaseController
{
    protected $repository;
    protected $validator;

    public function __construct(Container $container, PacienteIdentificacaoRepository $repository, PacienteIdentificacaoValidator $validator)
    {
        parent::__construct($container);
        $this->repository = $repository;
        $this->validator = $validator;
    }

    public function createView(Request $request, Response $response, $args)
    {
        $data['codigo_paciente'] = $args['codigo_paciente'];        
        return $this->viewRender($response, 'paciente/identificacao.html', $data);
    }

    public function editView(Request $request, Response $response, $args)
    {
        $data['codigo_paciente'] = $args['codigo_paciente'];        
        $data['codigo'] = $args['codigo'];
        return $this->viewRender($response, 'paciente/identificacao.html', $data);
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
}
