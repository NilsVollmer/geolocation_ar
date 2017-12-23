# frozen_string_literal: true

require_relative '../test_helper'
class GeocoderTest < ActiveSupport::TestCase
  let(:object) { Geocoder.new }

  before do
    Net::HTTP.any_instance.stubs(:request)
  end

  describe '#geocode_long_lat_hash' do
    it 'should call #get_by_api with apropriate test data' do
      object.expects(:get_by_api).with(
        'TestLocation', :test
      )

      object.geocode_long_lat_hash 'TestLocation'
    end

    it 'should not #parse_results_by_api with api-response nil' do
      object.expects(:parse_results_by_api).with(nil, :test).never
      object.geocode_long_lat_hash 'TestLocation'
    end
  end

  describe '#get_by_api' do
    it 'should call GoogleApiCommunicator.get_location with apropriate data' do
      GoogleApiCommunicator.any_instance.expects(:get_location).with('test')
      object.send(:get_by_api, 'test', :google)
    end

    it 'should call OsmApiCommunicator.get_location with apropriate data' do
      OsmApiCommunicator.any_instance.expects(:get_location).with('test')
      object.send(:get_by_api, 'test', :osm)
    end
  end

  describe '#parse_results_by_api' do
    it 'should call #first_long_lat_google with apropriate data' do
      faked_api_result = OpenStruct.new(body: '{"someKey":"someValue"}')
      object.expects(:first_long_lat_google).with('someKey' => 'someValue')
      object.send(:parse_results_by_api, faked_api_result, :google)
    end

    it 'should call #first_long_lat_osm with apropriate data' do
      faked_api_result = OpenStruct.new(body: '{"someKey":"someValue"}')
      object.expects(:first_long_lat_osm).with('someKey' => 'someValue')
      object.send(:parse_results_by_api, faked_api_result, :osm)
    end
  end

  describe '#first_long_lat_google' do
    it 'should return only the first long/lat pair as result' do
      google_json = {
        'results' => [
          { 'geometry' => { 'location' => { 'lat' => '1', 'lng' => '1' } } },
          { 'geometry' => { 'location' => { 'lat' => '2', 'lng' => '2' } } }
        ]
      }
      result = object.send(:first_long_lat_google, google_json)
      result.must_equal('latitude' => '1', 'longitude' => '1')
    end

    it 'should return status-hash for empty results' do
      google_json = { 'results' => [], 'status' => 'ZERO_RESULTS' }
      result = object.send(:first_long_lat_google, google_json)
      result.must_equal('status' => 'ZERO_RESULTS')
    end
  end

  describe '#first_long_lat_osm' do
    it 'should return only the first long/lat pair as result' do
      osm_json = [
        { 'lat' => '1', 'lon' => '1' },
        { 'lat' => '2', 'lon' => '2' }
      ]
      result = object.send(:first_long_lat_osm, osm_json)
      result.must_equal('latitude' => '1', 'longitude' => '1')
    end

    it 'should return status-hash for empty results' do
      osm_json = []
      result = object.send(:first_long_lat_osm, osm_json)
      result.must_equal('status' => 'ZERO_RESULTS')
    end
  end
end
