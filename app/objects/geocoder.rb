# frozen_string_literal: true
class Geocoder
  # TODO: Error handling (API URL changes, service offline, timeouts?)

  def geocode_long_lat_hash query_string
    api_sym = Rails.application.secrets.geocode[:geocoding_api].to_sym
    http_response = get_by_api(query_string, api_sym)
    parse_results_by_api(http_response, api_sym)
  end

  private

  def get_by_api query_string, api = :google
    case api
    when :google
      GoogleApiCommunicator.new.get_location(query_string)
    else
      # NOTE use osm per default (e.g. wrong ENV setup overwriting default)
      OsmApiCommunicator.new.get_location(query_string)
    end
  end

  # API-dependent parsing of the result body to json format. Returns only the
  # best (first) result and sets status code when there are no results.
  # Can be extended to support additional third-party-APIs (shown with osm)
  def parse_results_by_api result, api = :google
    parsed_json = JSON.parse(result.body)
    case api
    when :google
      result = parsed_json['results'].map do |result|
        {
          'latitude' => result['geometry']['location']['lat'],
          'longitude' => result['geometry']['location']['lng']
        }
      end.first
      result = { 'status' => parsed_json['status'] } unless result
      result
    when :osm
      result = parsed_json.map do |result|
        {'latitude' => result['lat'], 'longitude' => result['lon']}
      end.first
      # NOTE: nominatim just returns an empty result for unfound/empty queries
      # so we return the same status as the google API does in this case
      result = { 'status' => 'ZERO_RESULTS' } unless result
      result
    end
  end
end
