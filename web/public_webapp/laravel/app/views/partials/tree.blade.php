@section('tree')

  <div class="list-group">
    <a href="#" class="list-group-item">Item 1</a>
    <a href="#" class="list-group-item">Item 2</a>
    <a href="#" class="list-group-item">Item 3</a>
    @foreach($tree as $node)
      <a href="#" class="list-group-item">{{ $node["title"] }}</a>
    @endforeach
  </div>

@endsection