class StudentsController < ApplicationController
  include InBloomHelper
  def index
    student_container_url = params[:root_link]
    student_container_json = get(student_container_url)
    @section = hashie_from_json(student_container_json)
    students_url = href_for(@section, 'getStudents')
    students_json = get(students_url)
    @students = hashie_from_json(students_json)
    student_grades = student_grades(@section, @students)
    #assign average grade
    @students.each {|student| student.average_grade = student_grades[student.id][:average_grade]}
    @students
  end

end
