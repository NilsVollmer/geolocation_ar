### SimpleCOV ###
require 'simplecov'
require 'coveralls'

SimpleCov.start 'rails' do
  add_filter "/test/"
  minimum_coverage 100
end

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]

# Coveralls.wear!('rails')
