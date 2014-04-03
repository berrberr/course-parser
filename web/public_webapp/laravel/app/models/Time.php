<?php

class Time extends Eloquent {
  
  protected $table = 'times';

  public function professor() {
    return $this->hasOne('Professor', 'id', 'professor_id');
  }

  public function parseTimes() {
    $times = explode(';', $this->times);
    $output = [];
    foreach($times as $time) {
      $inner_times = explode('*', substr($time, 2));
      if(sizeof($inner_times) > 1) {
        $start_time = $inner_times[0];
        $end_time = $inner_times[1];

        $output[] = ['day' => substr($time, 0, 2),
                      'start_time' => $start_time,
                      'end_time' => $end_time];
      }
    }
    return $output;
  }
}