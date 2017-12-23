# frozen_string_literal: true

require_relative '../test_helper'

describe SearchLocationsController do
  describe "GET 'show'" do
    it 'should succeed even with none-UTF8-Encoding' do
      query = 'epiç query'
      # stub Geocoder call to prevent API-calls in test
      Geocoder.any_instance.expects(:geocode_long_lat_hash).with(
        query.encode(Encoding::UTF_8)
      ).returns('longitude' => '42', 'latitude' => '42')
      get :show, params: { query: query, format: :html }
      assert_response :success
    end
  end
end
