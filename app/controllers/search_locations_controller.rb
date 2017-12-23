# frozen_string_literal: true

class SearchLocationsController < ApplicationController
  respond_to :html

  def show
    query_string = params[:query].encode(Encoding::UTF_8)
    result = Geocoder.new.geocode_long_lat_hash(query_string)
    render json: result
  end
end
