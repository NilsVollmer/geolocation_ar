# frozen_string_literal: true

require_relative '../test_helper'
class OsmApiCommunicatorTest < ActiveSupport::TestCase
  let(:object) { OsmApiCommunicator.new }

  before do
    Net::HTTP.any_instance.stubs(:request)
  end

  describe '#get_location' do
    it 'should end up in an HTTP request' do
      Net::HTTP.any_instance.expects :request
      object.get_location 'TestLocation'
    end

    it 'should call #get_from_api with apropriate data' do
      object.expects(:get_from_api).with(
        q: 'TestLocation', countrycodes: 'test', format: :json
      )

      object.get_location 'TestLocation'
    end
  end
end
