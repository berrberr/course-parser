<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It's a breeze. Simply tell Laravel the URIs it should respond to
| and give it the Closure to execute when that URI is requested.
|
*/

Route::get('/', function()
{
	return View::make('home')->with('tree', TreeController::getTree());
});

//Single course view
Route::get('/course/{subject_code}/{course_code}', array(
  'as' => 'course', 
  function($subject_code, $course_code) {
    $course = Course::getCourseByCodeSubject($course_code, $subject_code);
    if(isset($course)) {
      return View::make('course')->with('course', $course);
    } else {
      return View::make('course')->with('error', 404);
    }
  })
);

//All subject page home
Route::get('/subject', function() {
  return View::make('subjecthome')->with('tree', TreeController::getTree());
});

//Subject course view
Route::get('/subject/{subject_code}', array(
  'as' => 'subject',
  'uses' => 'SubjectController@getSubject')
);

