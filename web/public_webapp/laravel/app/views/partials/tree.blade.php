@section('tree')

  <div class="list-group">
    @foreach($tree as $subject)
      <div class="col-sm-12" id="{{ $subject->subject_code }}">
        {{ link_to_route(
            'subject',
            $subject->name,
            [$subject->subject_code],
            array('class' => 'list-group-item subject-node')
        )}}
        <div class="col-sm-11 course-nodes">
          {{-- @foreach($subject->courses as $course)
            {{ link_to_route('course', 
                              $course->code . ': ' . $course->title, 
                              [$course->subject_code, $course->code], 
                              array('class' => 'list-group-item course-node'))}}
          @endforeach --}}
        </div>
      </div>
      @endforeach
  </div>

@endsection