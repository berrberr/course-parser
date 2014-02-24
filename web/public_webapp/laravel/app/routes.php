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
  $tree = TreeController::getTree();
	return View::make('home')->with('tree', $tree);
});

Route::get('/courses', function()
{
  $c = new Course();
  $course = $c->getCourseByCodeSubject('1AA3', 'ANTHROP');
  echo $course->description;
  //echo $c->getCoursesBySubject('COMP SCI');

});