@extends('layouts.scaffold')
@include('partials.tree')

@section('main')
  <div class="container main-container">
    <div class="row">
      <div class="col-sm-5">
        @yield('tree')
      </div>
    </div>
  </div>
@endsection