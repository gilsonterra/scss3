<?php

namespace App\Validators;

use Respect\Validation\Validator as v;
use Respect\Validation\Exceptions\NestedValidationException;

final class PacienteIdentificacaoValidator extends BaseValidator
{
    public function valid($data)
    {
        $errors = [];
        $messages = [
            'nome_pac'               => 'Campo obrigatório.',
            'sexo_pac'               => 'Campo obrigatório.',            
            'data_nasc_pac.notEmpty' => 'Campo obrigatório.',
            'data_nasc_pac.date'     => 'Formato da data é inválido (DD/MM/AAAA).',
        ];

        try {
            v::key('nome_pac', v::stringType()->notEmpty())
                ->key('sexo_pac', v::stringType()->notEmpty())
                ->key('data_nasc_pac', v::date('d/m/Y')->notEmpty())
                ->assert($data);
        } catch (NestedValidationException $e) {
            $messagesException = $e->findMessages($messages);
            $errors = $this->createArrayMessage($data, $messagesException);
        }
    
        return $errors;
    }
}
