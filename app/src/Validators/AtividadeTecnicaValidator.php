<?php

namespace App\Validators;

use Respect\Validation\Validator as v;
use Respect\Validation\Exceptions\NestedValidationException;

final class AtividadeTecnicaValidator extends BaseValidator
{
    public function valid($data)
    {
        try {
            $errors = [];
            $messages = [
                'data_cadastro.notEmpty' => 'Campo obrigatório.',
                'data_cadastro.date'     => 'Formato da data é inválido (DD/MM/AAAA).',
                'data_cadastro.max'      => 'A data do cadastro não pode ser maior que hoje.',
                'fk_local'               => 'Campo obrigatório.',
                'fk_acompanhamento'      => 'Campo obrigatório.',
                'relato'                 => 'Campo obrigatório.',
            ];

            v::key('data_cadastro', v::notEmpty()->date('d/m/Y'))->assert($data);

            $data['data_cadastro'] = \DateTime::createFromFormat('d/m/Y', $data['data_cadastro']);
            $dataAtual = new \DateTime();
            
            v::key('data_cadastro', v::date()->max($dataAtual, true))
                ->key('fk_local', v::stringType()->notEmpty())
                ->key('fk_acompanhamento', v::stringType()->notEmpty())
                ->key('relato', v::stringType()->notEmpty())
                ->assert($data);
        } catch (NestedValidationException $e) {
            $messagesException = $e->findMessages($messages);
            $errors = $this->createArrayMessage($data, $messagesException);
        }
        
        return $errors;
    }
}
