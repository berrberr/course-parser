<?php

//** Config **//
error_reporting(E_ALL);
define('APP_PATH', '../app/');

//** Load vendor libraries **//
require APP_PATH . 'vendor/autoload.php';
use RedBean_Facade as R;

//** Load custom helper functions **//
require APP_PATH . 'lib/helpers.php';

//** Global app **//
$app = new \Slim\Slim();

//** Setup Database **//
R::setup('mysql:host=127.0.0.1;dbname=coursesite','root','');
R::freeze(true);

//** Load routes **//
require APP_PATH . 'routes/course.php';
require APP_PATH . 'routes/subject.php';

//** Run app **//
$app->run();

?>
