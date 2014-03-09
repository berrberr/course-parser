<?php

class SubjectController extends BaseController {

  public function __construct() {
  }

  public function getSubject($subject_code) {
    $subject = Subject::find($subject_code);
    $tree = new TreeController;
    return View::make('subject')->with(array(
      'subject' => $subject, 
      'courses' => $subject->courses,
      'tree' => $tree->getTree()
      ));
  }

  public function getSubjectCourses($subject_code) {
    return Subject::find($subject_code)->courses();
  }

}