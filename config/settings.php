<?php
return [
    'settings' => [
        'debug'               => true,
        'displayErrorDetails' => true,
        'view'                => [
          'template_path' => __DIR__ . '/../resources/views/',
          'twig'          => [
            'cache'       => __DIR__ . '/../storage/cache',
            'debug'       => true,
            'auto_reload' => true,
          ],
        ],
        'db' => [
          'driver'       => 'oracle',
          'host'         => '192.168.1.11',
          'port'         => '1521',
          'database'     => 'scss',
          'service_name' => 'orcl',
          'username'     => 'scss',
          'password'     => 'sscs4321',
          'schema'       => 'trans',
          'charset'      => 'AL32UTF8',
          'prefix'       => '',
      ],
    ]
];