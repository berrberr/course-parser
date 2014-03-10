@extends('layouts.scaffold')
@include('partials.tree')


@section('main')
  <div class="jumbotron">Subjects</div>
  <div class="row">
    <div class="col-xs-3">
      @yield('tree')
    </div>
    <div class="col-xs-9">
      This is the subject home page. Click on a subject to see it's courses.
    </div>
  </div>
@endsection