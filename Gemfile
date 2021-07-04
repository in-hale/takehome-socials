# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

ruby '2.7.3'

gem 'curb', '~> 0.9.11'
gem 'webrick', '~> 1.7'
gem 'zeitwerk', '~> 2.4.0'

group :development do
  gem 'rubocop', '~> 1.17.0'
  gem 'rubocop-rspec', '~> 2.4.0'
end

group :test, :development do
  gem 'pry-byebug'
  gem 'rspec', '~> 3.10.0'
end
