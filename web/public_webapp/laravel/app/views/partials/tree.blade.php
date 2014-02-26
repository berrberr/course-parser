@section('tree')

  <div class="list-group">
    @foreach($tree as $subject)
      <div class="col-sm-12"><a href="#" class="list-group-item subject-node">{{ $subject->name }}</a></div>
      <div class="col-sm-11 course-nodes">
        @foreach($subject->courses as $course)
          <a href="#" class="list-group-item course-node">{{ $course->code }}: {{ $course->title }}</a>
        @endforeach
      </div>
    @endforeach
  </div>

@endsection