<?php

use Illuminate\Database\Migrations\Migration;

class CreateSubjectsTable extends Migration {

    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('subjects', function($table) {
            $table->increments('id');
            $table->string('subject_code', 16);
            $table->string('name', 256)->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::drop('subjects');
    }

}