# frozen_string_literal: true

source 'https://rubygems.org'

# git_source(:github) do |repo_name|
#   repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
#   "https://github.com/#{repo_name}.git"
# end

###########
# General #
###########

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'responders'
gem 'json'

########################
# For Heroku & Add-Ons #
########################

# group :production, :staging do
#   gem 'rails_12factor' # heroku recommends this
#   gem 'heroku-deflater' # gzip compression
# end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution & get a debug console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  # gem 'selenium-webdriver'
end

#####################
# Dev/Test Specific #
#####################

group :development do
  # startup
  gem 'spring' # faster rails start

  # errors
  gem 'better_errors'
  gem 'binding_of_caller'

  # debugging in chrome with RailsPanel
  gem 'meta_request'

  gem 'foreman'
end

group :test do
  gem 'rake'
  gem 'fakeweb', '~> 1.3'
  gem 'webmock'
  gem 'pry-rescue'
end

group :development, :test do
  # debugging
  gem 'pry-rails' # pry is awsome
  gem 'hirb' # hirb makes pry output even more awesome
  gem 'pry-byebug' # kickass debugging
  gem 'pry-stack_explorer' # step through stack
  gem 'pry-doc' # read ruby docs in console

  # test suite
  gem 'rails-controller-testing'
  gem 'minitest', '5.10.3' # Testing using Minitest
  gem 'minitest-matchers'
  gem 'minitest-line'
  gem 'launchy' # save_and_open_page
  gem 'shoulda'
  gem 'minitest-rails-capybara'
  gem 'mocha'

  # test suite additions
  gem 'rails_best_practices'
  gem 'brakeman' # security test: execute with 'brakeman'
  gem 'rubocop', '0.49.1' # style enforcement
  gem 'colorize' # output coloring

  # Code Coverage
  gem 'simplecov', require: false
  gem 'coveralls', require: false
  gem 'codeclimate-test-reporter', require: false

  # dev help
  gem 'thin' # Replace Webrick
  gem 'bullet' # Notify about n+1 queries
  gem 'dotenv-rails' # handle environment variables
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
