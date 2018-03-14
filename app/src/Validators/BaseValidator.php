<?php

namespace App\Validators;

abstract class BaseValidator
{
    public function createArrayMessage(array $data, $messagesException)
    {
        $errors = [];
        if (!empty($messagesException)) {
            foreach ($data as $key => $value) {
                foreach ($messagesException as $k => $v) {
                    if (strpos($k, $key) !== false && !empty($v)) {
                        $errors[$key][] = $v;
                    }
                }
            }
        }

        return $errors;
    }
}
