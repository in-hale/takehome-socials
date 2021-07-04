# frozen_string_literal: true

module Models
  Source = Struct.new(:name, :key, :url, keyword_init: true)
end
