<?php

namespace App\Validators;

use Respect\Validation\Validator as v;
use Respect\Validation\Exceptions\NestedValidationException;

final class AtividadeTecnicaValidator extends BaseValidator
{
    public function valid($data)
    {
        $errors = [];
        $messages = [
            'relato'      => 'Campo obrigatório.',
            //'ramal.notEmpty' => 'Campo obrigatório.',
            //'ramal.intVal'   => 'Campo deve ser número.',            
            //'ramal.length'   => 'Campo deve ter 4 caracteres.'
        ];

        try {
            v::key('relato', v::stringType()->notEmpty())
                 //->key('ramal', v::intVal()->notEmpty()->length(4, 4))
                 ->assert($data);
        } catch (NestedValidationException $e) {
            $messagesException = $e->findMessages($messages);
            $errors = $this->createArrayMessage($data, $messagesException);
        }
        
        return $errors;
    }
}
