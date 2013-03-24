class KlassesController < ApplicationController
  # GET /klasses
  # GET /klasses.json
  def index
    sections = inbloom_get('sections')
    @klasses = hashie_from_json(sections)
    teacher_url = href_for(@klasses.first, :getTeachers)
    teacher_json = get(teacher_url)
    @teacher = hashie_from_json(teacher_json).first

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: klasses }
    end
  end
end
