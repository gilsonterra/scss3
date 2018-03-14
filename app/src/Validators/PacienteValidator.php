<?php

namespace App\Validators;

use Respect\Validation\Validator as v;
use Respect\Validation\Exceptions\NestedValidationException;

final class PacienteValidator extends BaseValidator
{
    public function valid($data)
    {
        $errors = [];
        $messages = [
            'nome_pac'      => 'Campo obrigatório.',
            'sexo_pac'          => 'Campo obrigatório.',
            'data_nasc_pac' => 'Campo obrigatório.',
        ];

        try {
            v::key('nome_pac', v::stringType()->notEmpty())
                ->key('sexo_pac', v::stringType()->notEmpty())
                ->key('data_nasc_pac', v::stringType()->notEmpty())
                ->assert($data);
        } catch (NestedValidationException $e) {
            $messagesException = $e->findMessages($messages);
            $errors = $this->createArrayMessage($data, $messagesException);
        }
    
        return $errors;
    }
}
