<?php

namespace App\Validators;

use Respect\Validation\Validator as v;
use Respect\Validation\Exceptions\NestedValidationException;

final class PacienteAcompanhamentoValidator extends BaseValidator
{
    public function valid($data)
    {
        $errors = [];
        $messages = [
            'relato'                 => 'Campo obrigatório.',
            'data_cadastro.notEmpty' => 'Campo obrigatório.',
            'data_cadastro.date'     => 'Formato da data é inválido (DD/MM/AAAA).',
        ];

        try {
            v::key('relato', v::stringType()->notEmpty())
                ->key('data_cadastro', v::date('d/m/Y')->notEmpty())
                ->assert($data);
        } catch (NestedValidationException $e) {
            $messagesException = $e->findMessages($messages);
            $errors = $this->createArrayMessage($data, $messagesException);
        }
        
        return $errors;
    }
}
