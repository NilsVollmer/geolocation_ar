# frozen_string_literal: true

require_relative '../test_helper'
class GoogleApiCommunicatorTest < ActiveSupport::TestCase
  let(:object) { GoogleApiCommunicator.new }

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
        address: 'TestLocation', region: 'test', key: 'test'
      )

      object.get_location 'TestLocation'
    end
  end
end
