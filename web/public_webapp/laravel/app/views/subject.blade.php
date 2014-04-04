@extends('layouts.scaffold')
@include('partials.tree')


@section('main')
  @if(isset($subject))
    <div class="jumbotron">{{ $subject->name }}</div>
    <div class="row main-content">
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
                  <div class="col-xs-1 course-time">
                    <em>Times:</em>
                  </div>
                  <div class="col-xs-11 course-time">
                      @foreach($course->times as $time)
                        <div class="col-xs-4">
                        <table>
                          <tr><td><b>Term: </b>{{ $time->term }}</td></tr>
                          <tr><td><b>Core: </b>{{ $time->core }}</td></tr>
                          <tr>
                            @if($time->professor)
                              <td>
                              <b>Instructor: </b>
                              {{ $time->professor->last_name }}, {{ $time->professor->first_name }}
                              </td>
                            @else
                              <td><b>Instructor: </b>No instructor yet.</td>
                            @endif
                          </tr>
                          @foreach($time->parseTimes() as $slot)
                            <tr>
                              <td><b>{{ $slot["day"] }}</b> {{ $slot["start_time"] }} - {{ $slot["end_time"] }}</td>
                            </tr>
                          @endforeach
                        </table>
                          <span class="registrar-link">
                          {{ $time->registrarLink($course) }}
                          </span>
                        </div>
                      @endforeach
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