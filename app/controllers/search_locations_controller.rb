# frozen_string_literal: true

# TODO? Request capped via Rack::Attack to prevent external abuse.
class SearchLocationsController < ApplicationController
  respond_to :html

  def show
    query_string = params[:query].force_encoding('UTF-8')
    result = Geocoder.new.geocode_long_lat_hash(query_string)
    render json: result
  end
end
