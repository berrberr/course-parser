<?php

class Subject extends Eloquent {

  protected $table = 'subjects';

  public function getAll() {
    return Subject::all();
  }

  public function getSubjectByCode($subject_code) {
    return Subject::where('subject_code', '=', $subject_code)->get();
  }
}

?>