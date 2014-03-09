@extends('layouts.scaffold')
@include('partials.tree')


@section('main')
  @if(isset($subject))
    <div class="jumbotron">subject home</div>
    <div class="row">
      <div class="col-xs-3">
        @yield('tree')
      </div>
      <div class="col-xs-9">
        This is the subject home page. Click on a subject to see it's courses.
      </div>
    </div>
  @endif
@endsection