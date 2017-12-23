# frozen_string_literal: true

class Geocoder
  # TODO: Error handling (API URL changes, service offline, timeouts?)

  def geocode_long_lat_hash query_string
    api_sym = Rails.application.secrets.geocode[:geocoding_api].to_sym
    http_response = get_by_api(query_string, api_sym)
    http_response ? parse_results_by_api(http_response, api_sym) : {}
  end

  private

  # API-dependent call of the corresponding communicator classes
  # get_location-method and returns the API result.
  def get_by_api query_string, api = :google
    case api
    when :google
      GoogleApiCommunicator.new.get_location(query_string)
    else
      # NOTE use osm per default (e.g. wrong ENV setup overwriting default)
      OsmApiCommunicator.new.get_location(query_string)
    end
  end

  # API-dependent parsing of the result body to json format. Returns only
  # the best (first) result and sets status code when there are no results.
  # Can be extended to support additional third-party-APIs (shown with osm)
  def parse_results_by_api result, api = :google
    parsed_json = JSON.parse(result.body)
    case api
    when :google
      first_long_lat_google(parsed_json)
    when :osm
      first_long_lat_osm(parsed_json)
    end
  end

  # parses google results and returns only the first long/lat value pair.
  # Result.status is returned in case of and empty result.
  def first_long_lat_google parsed_json
    result = parsed_json['results'].map do |res|
      {
        'latitude' => res['geometry']['location']['lat'],
        'longitude' => res['geometry']['location']['lng']
      }
    end.first
    result = { 'status' => parsed_json['status'] } unless result
    result
  end

  # NOTE: nominatim just returns an empty result for unfound/empty queries
  # so we return the same status as the google API does in this case
  def first_long_lat_osm parsed_json
    result = parsed_json.map do |res|
      { 'latitude' => res['lat'], 'longitude' => res['lon'] }
    end.first
    result = { 'status' => 'ZERO_RESULTS' } unless result
    result
  end
end
