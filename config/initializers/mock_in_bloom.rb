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
                    {id: 'STUDENT1',
                     name: {lastSurname: 'Potter', firstName: 'Harry'},
                     links: [rel: 'getStudentGradebookEntries', href: 'http://example.com/student_gradebook_entries']
                    }
                ].to_json,
                :headers => {})

  stub_request(:get, "http://example.com/student_gradebook_entries").
      with(:headers => {'Accept' => 'application/vnd.slc+json', 'Authorization' => 'bearer', 'Content-Type' => 'application/vnd.slc+json'}).
      to_return(:status => 200,
                :body => [
                    {studentId: 'STUDENT1', sectionId: 'SECTION1', numericGradeEarned: 89}
                ].to_json,
                :headers => {})
end
