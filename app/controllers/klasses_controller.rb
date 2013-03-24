class KlassesController < ApplicationController
  # GET /klasses
  # GET /klasses.json
  def index
    klasses = {:klasses => JSON.parse(inbloom_get('sections'))}
    @klasses = Hashie::Mash.new(klasses).klasses

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: klasses }
    end
  end
end
