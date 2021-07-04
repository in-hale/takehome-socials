# frozen_string_literal: true

class Application

  DEFAULT_AVAILABLE_SOURCES = [
    Models::Source.new(name: 'twitter', key: 'tweets', url: 'https://takehome.io/twitter'),
    Models::Source.new(name: 'facebook', key: 'posts', url: 'https://takehome.io/facebook')
  ].freeze
  DEFAULT_SOURCE_NAMES_TO_SCRAPE = %w[twitter facebook].freeze

  def self.run
    options = Commands::ParseOptions.new(sources: DEFAULT_AVAILABLE_SOURCES).call

    Server.new(available_sources: options[:sources], default_sources: DEFAULT_SOURCE_NAMES_TO_SCRAPE).run
  end

end
