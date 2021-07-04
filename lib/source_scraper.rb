# frozen_string_literal: true

class SourceScraper

  def initialize(available_sources:, source_names:, http_client: Adapters::CurlHttpClient)
    @sources = available_sources.select { |source| source_names.include?(source.name) }
    @http_client = http_client
  end

  def call
    output = {}

    sources.map do |source|
      Thread.new { output.merge!(source.key => do_resilient_request(source.url)) }
    end.map(&:join)

    output
  end

  private

  attr_reader :sources, :http_client

  def do_resilient_request(url)
    request = http_client.new(url)

    loop do
      response = request.perform

      break JSON.parse(response.body_str) if response.status.eql?('200')
    end
  end

end
