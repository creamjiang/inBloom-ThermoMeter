module InBloomHelper
  def average_grade(student, section)
    section_url = href_for(section, :self)
    section_json = get(section_url)
    section = hashie_from_json(section_json)
    all_student_gradebook_entries_url = href_for(section, 'getStudentGradebookEntries')
    # scope to this student
    gradebook_entries_url = all_student_gradebook_entries_url + "&studentId=#{student.id}"
    # following code needs addressable gem
    #gradebook_entries_url = URI.parse(all_student_gradebook_entries_url)
    #gradebook_entries_url.query_values = gradebook_entries_url.query_values.merge(:studentId => student.id)
    gradebook_entries_json = get(gradebook_entries_url)
    gradebook_entries = hashie_from_json(gradebook_entries_json)

    grades = gradebook_entries.collect { |entry| entry.numericGradeEarned || numeric_grade_for(entry.letterGradeEarned) }.compact

    if grades.empty?
      return 0
    else
      average_grade = (grades.inject(0.0) { |sum, el| sum + el } / grades.size).round
    end
  end

  def grade_color(score)
    case score
      when 61..85
        '#FFFF00' # yellow
      when 86..100
        'green'
      else
        'red'
    end
  end

  def student_grades(section, students)
    all_student_gradebook_entries_url = href_for(section, 'getStudentGradebookEntries')
    gradebook_entries_url = all_student_gradebook_entries_url
    gradebook_entries_json = get(gradebook_entries_url)
    gradebook_entries = hashie_from_json(gradebook_entries_json)

    students_with_grades = {}
    students.each do |student|
      entries_for_student = gradebook_entries.select { |entry| entry.studentId == student.id }
      grades = entries_for_student.collect { |entry| entry.numericGradeEarned || numeric_grade_for(entry.letterGradeEarned) }.compact

      average_grade = grades.mean

      students_with_grades[student.id] = {}
      students_with_grades[student.id][:grades] = grades
      students_with_grades[student.id][:average_grade] = average_grade
    end
    students_with_grades
  end

  def in_bloom_link_to(caption, item, rel)
    link_to caption, href_for(item, rel)
  end

  def full_name(item_with_name)
    name_node = item_with_name.name
    full_name = name_node.lastSurname
    if first_name = name_node.firstName
      full_name += ", #{first_name}"
    end
    full_name
  end


  def numeric_grade_for(letter_grade)
    case letter_grade
      when /A/
        95
      when /B/
        85
      when /C/
        75
      when /D/
        65
      else
        50
    end
  end
end
