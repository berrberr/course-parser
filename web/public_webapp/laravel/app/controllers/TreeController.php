<?php

class TreeController extends BaseController {
  
  public $subject;

  public function __construct() {
    $this->subject = new Subject();
  }


  public function getTree() {
    return $this->subject->getAll();
  }
}
