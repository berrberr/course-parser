<?php
use RedBean_Facade as R;

$app->get('/', function () use ($app) {
  echo 'Hello world';
});


//GET api/course
$app->get('/course', function() use ($app) {
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

//GET api/course/:id
$app->get('/course/:id', function($id) use ($app) {
  try {
    $course = R::find('courses', 'code = "' . $id . '"');
    if($course) {
      $app->response()->header('Content-Type', 'application/json');
      echo json_encode(R::exportAll($course));
    } else {
      $app->response->status(404);
      echo '404: Course not found';
    }  
  } catch(Exception $e) {
    $app->response->status(500);
  }
});

//Full text search on courses
//GET api/course/search/:query
$app->get('/course/search/:query', function($query) use ($app) {
  try {
    $results = R::getAll('SELECT * FROM courses WHERE MATCH(title, description) AGAINST("' . $query . '");');
    if($results) {
      $app->response->header('Content-Type', 'application/json');
      echo json_encode($results);
    } else {
      echo_err('No results found', 404);
    }
  } catch(Exception $e) {
    echo_err('Query failed', $e);
    echo('SELECT * FROM courses WHERE MATCH(title, description) AGAINST("' . $query . '")');
  }
});

//Simple search on courses for autocomplete
//GET api/course/search/:query
$app->get('/course/autocomplete/:query', function($query) use ($app) {
  try {
    $results = R::getAll('SELECT * FROM courses WHERE title LIKE "%' . $query . '%" OR code LIKE "%' . $query . '%"');
    if($results) {
      $app->response->header('Content-Type', 'application/json');
      echo json_encode($results);
    } else {
      echo_err('No results found', 404);
    }
  } catch(Exception $e) {
    echo_err('Query failed', $e);
    echo('SELECT * FROM courses WHERE MATCH(title, description) AGAINST("' . $query . '")');
  }
});

?>