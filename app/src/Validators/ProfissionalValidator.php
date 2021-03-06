<?php

namespace App\Validators;

use Respect\Validation\Validator as v;
use Respect\Validation\Exceptions\NestedValidationException;

final class ProfissionalValidator extends BaseValidator
{
    public function valid($data)
    {
        $errors = [];
        $messages = [
            'nome'   => 'Campo obrigatório.',
            'login'  => 'Campo obrigatório.',
            'senha'  => 'Senha não confere com a confirmação.',
            'locais' => 'Deve preencher pelo menos um local de atuação.'
        ];

        try {
            $data['locais'] = $this->_formatLocais($data['locais']);

            v::key('nome', v::stringType()->notEmpty()->setName('Nome'))
                 ->key('login', v::stringType()->notEmpty()->setName('Login'))
                 ->key('senha', v::equals($data['confirmar_senha']))
                 ->key('locais', v::arrayType()->notEmpty())
                 ->assert($data);
        } catch (NestedValidationException $e) {
            $messagesException = $e->findMessages($messages);
            $errors = $this->createArrayMessage($data, $messagesException);
        }

        return $errors;
    }

    protected function _formatLocais($locais)
    {
        $locaisFormatados = [];

        if (!empty($locais)) {
            if (is_array($locais)) {
                $locaisFormatados = $locais;
            } else {
                array_push($locaisFormatados, $locais);
            }
        }

        return $locaisFormatados;
    }
}
