# frozen_string_literal: true
class OsmApiCommunicator < NetCommunicator
  def initialize
    super 'https://nominatim.openstreetmap.org/search'
    @region = Rails.application.secrets.geocode[:geocoding_region]
  end

  def get_location location_query, format = :json
    get_from_api(q: location_query, countrycodes: @region, format: format)
  end
end
