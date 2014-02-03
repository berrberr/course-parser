<?php

//Sets response headers and echos an error message
function echo_err($err_msg, $status_code) {
  $app->response->status($status_code);
  echo $status_code . ': ' . $err_msg;
}
?>