@extends('layouts.scaffold')
@include('partials.tree')

<div class="container main-container">
  <div class="row">
    <div class="col-sm-4">
      @yield('tree')
    </div>
  </div>
</div>