#Course Viewer

##API

###Courses
**GET** /course (ALL courses)<br>
**GET** /course/:id<br>
**GET** /course/search/:query (Full text search on title and description)<br>
**GET** /course/autocomplete/:query (Simple search on title and code)<br>

###Subjects
**GET** /subject (ALL subjects)<br>
**GET** /subject/:id<br>
**GET** /subject/courses/:id (ALL courses belonging to subject with :id)<br>
