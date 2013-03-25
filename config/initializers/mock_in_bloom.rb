if APP_CONFIG['mock_in_bloom']
  require 'webmock'
  include WebMock::API

#stub_request(:any, 'https://api.sandbox.slcedu.org/api/rest/v1/sections')
#stub_request(:any, "https://api.sandbox.slcedu.org/api/oauth/authorize?response_type=code&client_id=FhedRG00Tk&redirect_uri=http%3A%2F%2Flocalhost%3A3000%2Fauth%2Fslc%2Fcallback&state=25e9bee39fdc7d93e62d6122818dedc7e0b04ded37df9afb")

  stub_request(:get, "https://api.sandbox.slcedu.org/api/rest/v1/sections").
      with(:headers => {'Accept' => 'application/vnd.slc+json', 'Authorization' => 'bearer', 'Content-Type' => 'application/vnd.slc+json'}).
      to_return(:status => 200,
                :body => [
                    {id: 'SECTION1',
                     uniqueSectionCode: 'SECTION ONE',
                     links: [{rel: 'self', href: 'http://example.com/sections/1'},
                             {rel: 'getTeachers', href: 'http://example.com/teachers'}]
                    }
                ].to_json,
                :headers => {})

  stub_request(:get, "http://example.com/teachers").
      with(:headers => {'Accept' => 'application/vnd.slc+json', 'Authorization' => 'bearer', 'Content-Type' => 'application/vnd.slc+json'}).
      to_return(:status => 200,
                :body => [{id: 'TEACHER1', name: {lastSurname: 'Struthers', firstName: 'Sally', personalTitlePrefix: 'Mrs'}}].to_json,
                :headers => {})

  stub_request(:get, "http://example.com/sections/1").
      with(:headers => {'Accept' => 'application/vnd.slc+json', 'Authorization' => 'bearer', 'Content-Type' => 'application/vnd.slc+json'}).
      to_return(:status => 200,
                :body => {id: 'SECTION1',
                          uniqueSectionCode: 'SECTION ONE',
                          links: [{rel: 'self', href: 'http://example.com/sections/1'},
                                  {rel: 'getStudents', href: 'http://example.com/students'},
                                  {rel: 'getStudentGradebookEntries', href: 'http://example.com/student_gradebook_entries'}

                          ]
                }.to_json,
                :headers => {})

  stub_request(:get, "http://example.com/students").
      with(:headers => {'Accept' => 'application/vnd.slc+json', 'Authorization' => 'bearer', 'Content-Type' => 'application/vnd.slc+json'}).
      to_return(:status => 200,
                :body => [
                    {id: 'STUDENT_HP',
                     name: {lastSurname: 'Potter', firstName: 'Harry'},
                     links: [rel: 'getStudentGradebookEntries', href: 'http://example.com/student_gradebook_entries?studentId=STUDENT_HP']
                    },
                    {id: 'STUDENT_HG',
                     name: {lastSurname: 'Granger', firstName: 'Hermione'},
                     links: [rel: 'getStudentGradebookEntries', href: 'http://example.com/student_gradebook_entries?studentId=STUDENT_HG']
                    },
                    {id: 'STUDENT_RW',
                     name: {lastSurname: 'Weasley', firstName: 'Ron'},
                     links: [rel: 'getStudentGradebookEntries', href: 'http://example.com/student_gradebook_entries?studentId=STUDENT_RW']
                    },
                    {id: 'STUDENT_VC',
                     name: {lastSurname: 'Crabb', firstName: 'Vincent'},
                     links: [rel: 'getStudentGradebookEntries', href: 'http://example.com/student_gradebook_entries?studentId=STUDENT_VC']
                    },
                ].to_json,
                :headers => {})

  stub_request(:get, "http://example.com/student_gradebook_entries").
      with(:headers => {'Accept' => 'application/vnd.slc+json', 'Authorization' => 'bearer', 'Content-Type' => 'application/vnd.slc+json'}).
      to_return(:status => 200,
                :body => [
                    {studentId: 'STUDENT_HP', sectionId: 'SECTION1', numericGradeEarned: 88},
                    {studentId: 'STUDENT_HG', sectionId: 'SECTION1', numericGradeEarned: 99},
                    {studentId: 'STUDENT_RW', sectionId: 'SECTION1', numericGradeEarned: 76},
                    {studentId: 'STUDENT_VC', sectionId: 'SECTION1', letterGradeEarned: 'E'},
                ].to_json,
                :headers => {})
end
