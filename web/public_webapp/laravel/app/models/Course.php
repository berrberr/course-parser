<?php

class Course extends Eloquent {

  protected $table = 'courses';

  public static function getCourseByCodeSubject($course_code, $subject_code) {
    return Course::where('course_code', '=', $course_code)->where('subject_code', '=', $subject_code)->first();
  }

  public function getCoursesBySubject($subject) {
    return Course::where('subject_code', '=', $subject)->get();
  }

  public function times() {
    return $this->hasMany('Time', 'course_code', 'course_code')->where('subject_code', $this->subject_code);
  }

  public function subject() {
    return $this->belongsTo('Subject', 'subject_code', 'subject_code');
  }
}


?>