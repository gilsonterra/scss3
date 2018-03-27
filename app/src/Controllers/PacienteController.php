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
        $data['codigo_paciente'] = $args['codigo_paciente'];
        return $this->viewRender($response, 'paciente/index.html', $data);
    }

    public function identificacaoView(Request $request, Response $response, $args)
    {
        $data['codigo_paciente'] = $args['codigo_paciente'];
        return $this->viewRender($response, 'paciente/identificacao.html', $data);
    }

    public function acompanhamentoView(Request $request, Response $response, $args)
    {
        $data['codigo_paciente'] = $args['codigo_paciente'];
        $data['codigo'] = $args['codigo'];
        return $this->viewRender($response, 'paciente/acompanhamento.html', $data);
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

    public function find(Request $request, Response $response, $args)
    {
        $codigoPaciente = $args['codigo_paciente'];
        $joins = $request->getParam('joins', []);
        $columns = $request->getParam('columns', ['*']);
        
        $data = $this->repository->findById($codigoPaciente, $joins, $columns)->toArray();

        return $this->jsonRender($response, 200, $data);
    }
}
