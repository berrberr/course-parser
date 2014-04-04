<?php

class Time extends Eloquent {
  
  protected $table = 'times';

  public function professor() {
    return $this->hasOne('Professor', 'id', 'professor_id');
  }

  public function subject() {
    return $this->belongsTo('Subject', 'subject_code', 'subject_code');
  }

  public function getDayCode() {
    return substr($this->daytime, 0, 1);
  }

  public function registrarLink($course) {
    return '<a href="https://adweb.cis.mcmaster.ca/mtt/spmastdtl.php?s=' . 
    $course->subject->mtt_code . '&c=' . 
    $course->course_code . '&t=' . 
    $this->term . '&d=' . 
    $this->getDayCode() . '" target="_blank">Go to registrar page</a>';
  }

  public function parseTimes($oneline = false) {
    $times = explode(';', $this->times);
    $output = $oneline ? "" : [];
    foreach($times as $time) {
      $inner_times = explode('*', substr($time, 2));
      if(sizeof($inner_times) > 1) {
        $start_time = $inner_times[0];
        $end_time = $inner_times[1];
        if($oneline) {
          $output .= '<b>' . substr($time, 0, 2) . '</b>' . $start_time . ' - ' . $end_time . '<br />';
        } else {
          $output[] = [
          'day' => substr($time, 0, 2),
          'start_time' => $start_time,
          'end_time' => $end_time];
        }
      }
    }
    return $output;
  }

}