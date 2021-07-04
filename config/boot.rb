# frozen_string_literal: true

require 'bundler/setup'

Bundler.require(:default, ENV.fetch('SOCIALS_ENV', :development))

require_relative 'zeitwerk'
require_relative 'application'
require 'json'
