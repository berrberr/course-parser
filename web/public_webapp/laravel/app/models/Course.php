<?php

class Course extends Eloquent {

  protected $table = 'courses';

  public static function getCourseByCodeSubject($course_code, $subject_code) {
    return Course::where('course_code', '=', $course_code)->where('subject_code', '=', $subject_code)->first();
  }

  public function getCoursesBySubject($subject) {
    return Course::where('subject_code', '=', $subject)->get();
  }
}

?>