@extends('layouts.scaffold')
@include('partials.tree')


@section('main')
  @if(isset($subject))
    <div class="jumbotron">{{ $subject->name }}</div>
    <div class="row">
      <div class="col-xs-3">
        @yield('tree')
      </div>
      <div class="col-xs-9">
        <table class="table table-bordered table-striped">
          @foreach($courses as $course)
            <tr>
              <td>
                <div class="row">
                  <div class="col-xs-2 col-sm-1">
                    {{ link_to_route('course', 
                        $course->course_code, 
                        [$course->subject_code, $course->course_code],
                        array('class' => 'course-list-title'))}}
                  </div> 
                  <div class="col-xs-11">
                    {{ link_to_route('course', 
                        $course->title, 
                        [$course->subject_code, $course->course_code],
                        array('class' => 'course-list-title'))}}
                  </div>
                  <div class="col-xs-12 course-list-description">
                    {{ $course->description }}
                  </div>
                  <div class="col-xs-12 course-time">
                    <em>Times:</em>
                  </div>
                  <div class="col-xs-12 course-instructor">
                    <em>Instructor:</em>
                  </div>
                </div>
              </td>
            </tr>
          @endforeach
        </table>
      </div>
    </div>
  @endif
@endsection