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
