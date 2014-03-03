<?php

class Subject extends Eloquent {

  protected $table = 'subjects';

  public function getAll() {
    return Subject::orderBy('name', 'asc')->get();
  }

  public function getSubjectByCode($subject_code) {
    return Subject::where('subject_code', '=', $subject_code)->get();
  }

  public function courses() {
    return $this->hasMany('Course', 'subject_code', 'subject_code');
  }
}

?>