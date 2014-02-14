#Course Viewer

##API

#Courses
**GET** /course (ALL courses)
**GET** /course/:id

**GET** /course/search/:query (Full text search on title and description)
**GET** /course/autocomplete/:query (Simple search on title and code)

#Subjects
**GET** /subject (ALL subjects)
**GET** /subject/:id
**GET** /subject/courses/:id (ALL courses belonging to subject with :id)
