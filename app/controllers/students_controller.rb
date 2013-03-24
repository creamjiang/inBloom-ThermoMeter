class StudentsController < ApplicationController

  def index
    student_container_url = params[:root_link]
    student_container_json = get(student_container_url)
    @student_container = hashie_from_json(student_container_json)
    students_url = href_for(@student_container, 'getStudents')
    students_json = get(students_url)
    @students = hashie_from_json(students_json)

  end

end
