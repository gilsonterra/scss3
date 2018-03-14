<?php

namespace App\Controllers;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Container as Container;
use App\Repositories\ProfissionalRepository;
use App\Validators\ProfissionalValidator;

final class ProfissionalController extends BaseController
{
    protected $repository;
    protected $validator;

    public function __construct(Container $container, ProfissionalRepository $repository, ProfissionalValidator $validator)
    {
        parent::__construct($container);
        $this->repository = $repository;
        $this->validator = $validator;
    }

    public function listView(Request $request, Response $response, $args)
    {
        $data = $request->getParams();
        $data['grid'] = $this->repository->fetchAll($data, true, $data['page'])->toArray();
        return $this->viewRender($response, 'profissional/list.html', $data);
    }

    public function createView(Request $request, Response $response, $args)
    {
        return $this->viewRender($response, 'profissional/form.html');
    }

    public function editView(Request $request, Response $response, $args)
    {
        $data['dados'] = $this->repository->findById($args['codigo'])->toArray();
        return $this->viewRender($response, 'profissional/form.html', $data);
    }

    public function store(Request $request, Response $response, $args)
    {
        $data['dados'] = $request->getParams();
        $data['errors'] = $this->validator->valid($data['dados']);

        if (empty($data['errors'])) {
            if (empty($args['codigo'])) {
                $data['message'] = $this->repository->create($data['dados']);
            } else {
                $data['message'] = $this->repository->edit($args['codigo'], $data['dados']);
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
