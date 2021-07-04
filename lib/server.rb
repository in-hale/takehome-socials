# frozen_string_literal: true

class Server

  def initialize(available_sources:, default_sources:, web_adapter: Adapters::Webrick.new)
    @available_sources = available_sources
    @default_sources = default_sources
    @web_adapter = web_adapter

    initialize_routes
  end

  def run
    web_adapter.start
  end

  private

  attr_reader :available_sources, :default_sources, :web_adapter

  def initialize_routes
    web_adapter.on('/') do |request, response|
      sources = request.query_string.nil? ? default_sources : request.query_string.split(',')

      sn_data = SourceScraper.new(available_sources: available_sources, source_names: sources).call

      response.body = sn_data.to_json
    end
  end

end
