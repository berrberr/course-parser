<?php

use Illuminate\Database\Migrations\Migration;

class CreateTimesTable extends Migration {

    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('times', function($table) {
            $table->increments('id');
            $table->string('course_code', 255);
            $table->string('subject_code', 255);
            $table->text('times');
            $table->integer('professor_id');
            $table->timestamp('created_at')->default("0000-00-00 00:00:00");
            $table->timestamp('updated_at')->default("0000-00-00 00:00:00");
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::drop('times');
    }

}