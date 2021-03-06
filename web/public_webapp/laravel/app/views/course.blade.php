@extends('layouts.scaffold')

@section('main')
  <div class="jumbotron">{{ $course->title }}</div>
  <div class="row">
    <div class="col-xs-8 col-xs-offset-2">
      {{ link_to_route(
          'subject',
          'Back to '.$course->subject_code,
          [$course->subject_code],
          array('class' => '')
      )}}
      <div class="panel panel-primary course-panel">
        <div class="panel-heading">
          <h3 class="panel-title">Course Info</h3>
        </div>
        <div class="panel-body">
          <table class="table course-table">
            <tbody>
              <tr>
                <td class="course-table-title">Code:</td>
                <td class="course-table-content">{{ $course->course_code }}</td>
              </tr>
              <tr>
                <td class="course-table-title">Title:</td>
                <td class="course-table-content">{{ $course->title }}</td>
              </tr>
              <tr>
                <td class="course-table-title">Description:</td>
                <td class="course-table-content">{{ $course->description }}</td>
              </tr>
              @if(!empty($course->prereq))
                <tr>
                  <td class="course-table-title">Prerequisites:</td>
                  <td class="course-table-content">{{ $course->prereq }}</td>
                </tr>
              @endif
              @if(!empty($course->antireq))
                <tr>
                  <td class="course-table-title">Antirequisites:</td>
                  <td class="course-table-content">{{ $course->antireq }}</td>
                </tr>
              @endif
              @if(!empty($course->crosslist))
                <tr>
                  <td class="course-table-title">Crosslist:</td>
                  <td class="course-table-content">{{ $course->crosslist }}</td>
                </tr>
              @endif
            </tbody>
          </table>
        </div>
      </div>
      <div class="panel panel-primary course-panel">
        <div class="panel-heading">
          <h3 class="panel-title">Timetable</h3>
        </div>
        <div class="panel-body">
        <table class="table course-timetable">
        <tr><th class="course-timetable-head" colspan=2>{{ $config["session"] }}</th></tr>
        <tbody>
        @foreach($times as $time)
          <tr><th class="course-timetable-core-head" colspan=2>Core: {{ $time->core }}</th></tr>
          <tr><td><b>Term:</b></td><td>{{ $time->term }}</td></tr>
          <tr><td><b>Instructor:</b></td><td>
          @if($time->professor)
            {{ $time->professor->last_name }}, {{ $time->professor->first_name }}
          @else
            No instructor yet.
          @endif
          </td></tr>
          <tr><td><b>Room:</b></td><td>{{ $time->room }}</td></tr>
          <tr><td><b>Times: </b></td><td>{{ $time->parseTimes(true) }}</td></tr>
        @endforeach
        </tbody>
        </table>
        </div>
      </div>
      
    </div>
  </div>
@endsection