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
            'relato'                    => 'Campo obrigatório.',
            'data_cadastro.notEmpty'    => 'Campo obrigatório.',
            'data_cadastro.date'        => 'Formato da data é inválido (DD/MM/AAAA).',
            'data_cadastro.max'         => 'A data do cadastro não pode ser maior que hoje.',
            'fk_local'                  => 'Campo obrigatório.',
            'categoria_acompanhamento'  => 'Campo obrigatório.',
            'fk_acompanhamento'         => 'Campo obrigatório.',
            'tipo_faturamento'          => 'Campo obrigatório.',
        ];

        try {
            v::key('relato', v::stringType()->notEmpty())
                ->key('data_cadastro', v::date('d/m/Y')->max(date("d/m/Y"))->notEmpty())
                ->key('fk_local', v::stringType()->notEmpty())
                ->key('categoria_acompanhamento', v::stringType()->notEmpty())
                ->key('fk_acompanhamento', v::stringType()->notEmpty())
                ->key('tipo_faturamento', v::stringType()->notEmpty())
                ->assert($data);
        } catch (NestedValidationException $e) {
            $messagesException = $e->findMessages($messages);
            $errors = $this->createArrayMessage($data, $messagesException);
        }
        
        return $errors;
    }
}
