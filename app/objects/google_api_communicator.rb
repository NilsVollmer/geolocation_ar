# frozen_string_literal: true

class GoogleApiCommunicator < NetCommunicator
  def initialize
    super 'https://maps.googleapis.com/maps/api/geocode/json'
    @key = Rails.application.secrets.google[:geocoding_key]
    @region = Rails.application.secrets.geocode[:geocoding_region]
  end

  def get_location location_query
    get_from_api(address: location_query, region: @region, key: @key)
  end
end
