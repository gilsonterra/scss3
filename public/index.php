<?php
session_start();
require '../vendor/autoload.php';

$settings = require '../config/settings.php';
$container = new \Slim\Container($settings);
require '../config/dependencies.php';
require '../config/controllers.php';

$app = new \Slim\App($container);
require '../config/middleware.php';
require '../config/routes.php';

$app->run();
