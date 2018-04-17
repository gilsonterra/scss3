<?php

namespace App\Validators;

use Respect\Validation\Validator as v;
use Respect\Validation\Exceptions\NestedValidationException;

final class ProfissaoValidator extends BaseValidator
{
    public function valid($data)
    {
        $errors = [];
        $messages = [
            'descricao'      => 'Campo obrigatório.'
        ];

        try {
            v::key('descricao', v::stringType()->notEmpty())                 
                 ->assert($data);
        } catch (NestedValidationException $e) {
            $messagesException = $e->findMessages($messages);
            $errors = $this->createArrayMessage($data, $messagesException);
        }
        
        return $errors;
    }
}
