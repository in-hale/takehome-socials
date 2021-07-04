# frozen_string_literal: true

require 'uri'

module Commands
  class ParseOptions

    URL_REGEX = URI::DEFAULT_PARSER.make_regexp
    SOURCE_ARG_REGEX = /^(?<name>[^\s]+) (?<key>[^\s]+) (?<url>#{URL_REGEX})$/.freeze

    def initialize(default_options = {}, raw_arguments = ARGV)
      @default_options = default_options
      @raw_arguments = raw_arguments
    end

    def call
      return default_options if raw_arguments.empty?

      {
        sources: raw_arguments.map { Models::Source.new(parse_source_attributes(_1)) }
      }
    end

    private

    attr_reader :default_options, :raw_arguments

    def parse_source_attributes(raw_source)
      match_data = SOURCE_ARG_REGEX.match(raw_source)
      raise Errors::InvalidSourceDefinition if match_data.nil?

      match_data.named_captures.transform_keys(&:to_sym)
    end

  end
end
