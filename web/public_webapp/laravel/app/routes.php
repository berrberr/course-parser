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

Route::get('/course/{subject_code}/{course_code}', array('as' => 'course', function($subject_code, $course_code) {
  return 'COURSE VIEW';
}));

//All subject page home
Route::get('/subject', function() {
  return View::make('subjecthome')->with('tree', TreeController::getTree());
});

//Subject course view
Route::get('/subject/{subject_code}', array(
  'as' => 'subject',
  'uses' => 'SubjectController@getSubject')
);

Route::get('/courses', function()
{
  $c = new Course();
  $course = $c->getCourseByCodeSubject('1AA3', 'ANTHROP');
  echo $course->description;
  //echo $c->getCoursesBySubject('COMP SCI');
});
