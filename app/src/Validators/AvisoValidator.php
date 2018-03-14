<?php

namespace App\Validators;

use Respect\Validation\Validator as v;
use Respect\Validation\Exceptions\NestedValidationException;

final class AvisoValidator extends BaseValidator
{
    public function valid($data)
    {
        $errors = [];
        $messages = [            
            'aviso.notEmpty' => 'Campo obrigatório.',
        ];

        try {
            v::key('aviso', v::stringType()->notEmpty())
                ->assert($data);
        } catch (NestedValidationException $e) {
            $messagesException = $e->findMessages($messages);
            $errors = $this->createArrayMessage($data, $messagesException);
        }
        
        return $errors;
    }
}
