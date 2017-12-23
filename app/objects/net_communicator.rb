# frozen_string_literal: true
require 'net/http'
require 'uri'

class NetCommunicator
  def initialize(base_uri)
    @uri = URI.parse(base_uri)
  end

  protected

  # adds params to base query, builds a get-request and sends it
  def get_from_api params
    @uri.query = URI.encode_www_form(params)
    request = Net::HTTP::Get.new(@uri)
    send_request_to_api request
  end

  def send_request_to_api request
    http = Net::HTTP.new(@uri.host, @uri.port)
    http.use_ssl = true
    http.request request
  end
end
