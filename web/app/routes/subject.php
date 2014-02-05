<?php
use RedBean_Facade as R;

//GET api/subject
$app->get('/subject', function() use ($app) {
  try {
    $subjects = R::find('subjects', ' ORDER BY name');
    if($subjects) {
      $app->response->header('Content-Type', 'application/json');
      echo json_encode(R::exportAll($subjects));
    }
  } catch (Exception $e) {
    echo_err('Query failed', 500);
  }
});

//GET api/subject/:id
$app->get('/subject/:id', function($id) use ($app) {
  try {
    $subject = R::find('subjects', 'subject_code = "' . $id . '"');
    if($subject) {
      $app->response()->header('Content-Type', 'application/json');
      echo json_encode(R::exportAll($subject));
    } else {
      echo_err('Subject not found', 404);
    }  } catch(Exception $e) {
    echo_err('Query failed', 500);
  }
});

//GET api/subject/courses/:id
//@return array of courses in subject
$app->get('/subject/courses/:id', function($id) use ($app) {
  try {
    $subject = R::find('subjects', 'subject_code = "' . $id . '"');
    if($subject) {
      $courses = R::find('courses', 'subject_code = "' . $id . '"');
      if($courses) {
        $app->response()->header('Content-Type', 'application/json');
        echo json_encode(R::exportAll($courses));
      } else {
        echo_err('Subject has no courses', 404);
      }
    } else {
      echo_err('Subject not found', 404);
    }  } catch(Exception $e) {
    echo_err('Query failed', 500);
  }
});

?>