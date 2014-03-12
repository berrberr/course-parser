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
      <div class="panel panel-primary">
        <div class="panel-heading">
          <h3 class="panel-title">Course Info</h3>
        </div>
        <div class="panel-body">
          <table class="table course-table">
            <tbody>
              <tr>
                <td class="course-table-title">Code:</td>
                <td class="course-table-content">{{ $course->code }}</td>
              </tr>
              <tr>
                <td class="course-table-title">Title:</td>
                <td class="course-table-content">{{ $course->title }}</td>
              </tr>
              <tr>
                <td class="course-table-title">Description:</td>
                <td class="course-table-content">{{ $course->description }}</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
      
      
    </div>
  </div>
@endsection