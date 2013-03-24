class KlassesController < ApplicationController
  # GET /klasses
  # GET /klasses.json
  def index
    @klasses = hashie_from_json(inbloom_get('sections'))

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: klasses }
    end
  end
end
