class Course
  include Mongoid::Document
  store_in collection: 'course_list'
  field :code, type: String
  field :description, type: String
  field :title, type: String
  field :subject_code, type: String
  field :prereq, type: String
  field :antireq, type: String
  field :crosslist, type: String
end
