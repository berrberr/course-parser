json.array!(@courses) do |course|
  json.extract! course, :id, :code, :description, :title, :subject_code, :prereq, :antireq, :crosslist
  json.url course_url(course, format: :json)
end
