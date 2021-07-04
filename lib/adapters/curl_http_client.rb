# frozen_string_literal: true

module Adapters
  class CurlHttpClient

    def initialize(url)
      @url = url
    end

    def perform
      curl_request = Curl::Easy.new(url) do |curl|
        curl.headers['Accept'] = 'application/json'
      end

      curl_request.perform
      curl_request
    end

    private

    attr_reader :url

  end
end
