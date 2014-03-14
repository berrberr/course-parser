<?php

use Illuminate\Database\Migrations\Migration;

class CreateCoursesTable extends Migration {

    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('courses', function($table) {
            $table->increments('id');
            $table->string('code', 16)->nullable();
            $table->string('subject_code', 16)->nullable();
            $table->string('title', 256)->nullable()->index();
            $table->text('description')->nullable();
            $table->text('prereq')->nullable();
            $table->text('antireq')->nullable();
            $table->text('crosslist')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::drop('courses');
    }

}