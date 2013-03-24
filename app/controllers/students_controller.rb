class StudentsController < ApplicationController
  
  def index
    student_container_url = params[:root_link]
    student_container_json = get(student_container_url)
    student_container = Hashie::Mash.new(JSON.parse(student_container_json))
    students_url = href_for(student_container, 'getStudents')
    students_json = get(students_url)
    @students = Hashie::Mash.new({:students => JSON.parse(students_json)}).students
  end

end
