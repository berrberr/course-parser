<?php

class TreeController extends BaseController {
  
  public $subject;

  public function __construct() {
    $this->subject = new Subject();
  }


  public static function getTree() {
    $subject = new Subject();
    return $subject->getAll();
  }
}
