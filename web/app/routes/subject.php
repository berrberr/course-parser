<?php
use RedBean_Facade as R;

//GET api/subject/all
$app->get('/subject/all', function() use ($app) {
  try {
    $subjects = R::find('subjects');
    if($subjects) {
      $app->response->header('Content-Type', 'application/json');
      echo json_encode(R::exportAll($subjects));
    }
  } catch (Exception $e) {
    $app->response->status(500);
  }
});

//GET api/subject/find/:id
$app->get('/subject/find/:id', function($id) use ($app) {
  try {
    $subject = R::find('subjects', 'subject_code = "' . $id . '"');
    if($subject) {
      $app->response()->header('Content-Type', 'application/json');
      echo json_encode(R::exportAll($subject));
    } else {
      $app->response->status(404);
      echo '404: Subject not found';
    }  } catch(Exception $e) {
    $app->response->status(500);
  }
});

//GET api/subject/courses/:id
$app->get('/subject/courses/:id', function($id) use ($app) {
  try {
    $subject = R::find('subjects', 'subject_code = "' . $id . '"');
    if($subject) {
      $courses = R::find('courses', 'subject_code = "' . $id . '"');
      if($courses) {
        $app->response()->header('Content-Type', 'application/json');
        echo json_encode(R::exportAll($courses));
      }
    } else {
      $app->response->status(404);
      echo '404: Subject not found';
    }  } catch(Exception $e) {
    $app->response->status(500);
  }
});

?>