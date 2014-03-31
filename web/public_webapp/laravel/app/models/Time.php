<?php

class Time extends Eloquent {
  
  protected $table = 'times';

  public function parseTimes() {
    $times = explode(';', $this->times);
    $output = [];
    foreach($times as $time) {
      $output[] = substr($time, 0, 2) . ' ' . substr($time, 3);
    }
    return $output;
  }
}