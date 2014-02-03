<?php
use RedBean_Facade as R;

$app->get('/', function () use ($app) {
  echo 'Hello world';
});


//GET api/course/all
$app->get('/course/all', function() use ($app) {
  try {
    $courses = R::find('courses');
    if($courses) {
      $app->response->header('Content-Type', 'application/json');
      echo json_encode(R::exportAll($courses));
    }
  } catch (Exception $e) {
    $app->response->status(500);
  }
});

//GET api/course/find/:id
$app->get('/course/find/:id', function($id) use ($app) {
  try {
    $course = R::find('courses', 'code = "' . $id . '"');
    if($course) {
      $app->response()->header('Content-Type', 'application/json');
      echo json_encode(R::exportAll($course));
    } else {
      $app->response->status(404);
      echo '404: Course not found';
    }  } catch(Exception $e) {
    $app->response->status(500);
  }
});


?>