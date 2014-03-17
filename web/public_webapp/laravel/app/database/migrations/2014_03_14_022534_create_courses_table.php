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
            $table->string('course_code', 16)->nullable();
            $table->string('subject_code', 16)->nullable();
            $table->string('title', 255)->nullable()->index();
            $table->text('description')->nullable();
            $table->text('prereq')->nullable();
            $table->text('antireq')->nullable();
            $table->text('crosslist')->nullable();
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
        Schema::drop('courses');
    }

}