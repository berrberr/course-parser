<?php

class Course extends Eloquent {

  protected $table = 'courses';

  public static function getCourseByCodeSubject($code, $subject_code) {
    return Course::where('code', '=', $code)->where('subject_code', '=', $subject_code)->first();
  }

  public function getCoursesBySubject($subject) {
    return Course::where('subject_code', '=', $subject)->get();
  }
}

?>