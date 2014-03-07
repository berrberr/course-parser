<?php

class SubjectController extends BaseController {
  public $subject;

  public function __construct() {
    $this->subject = new Subject();
  }

  public function getSubject($subject_code) {
    $subj = Subject::find($subject_code);
    var_dump($subj);
  }

}