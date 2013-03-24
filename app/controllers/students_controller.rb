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
    @students.each do |student|
      student.average_grade = student_grades[student.id][:average_grade]
      student.grades = student_grades[student.id][:grades]
    end

    #remove students with no grade due to:
    #  BUG: inBloom Section gradebookEntries does not match Student gradebookEntries
    @students = @students.reject {|student| student.average_grade == 0}

    @section.average_grade = @students.collect{|student| student.average_grade}.mean
    # TODO: mismatched datapoints for students, how to show trend?
    # TODO: hardcode "sample" trend
    @section.average_grades = [79,89,69,79]
    @students.sort_by! {|student| student.name.lastSurname}

  end

end
