ENV['RAILS_ENV'] ||= 'test'

require_relative './support/spec_helpers/coverage'

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails'
require 'minitest/rails/capybara'
require 'minitest/pride'
require 'mocha/mini_test'
require 'capybara/rails'

require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/mock'
require 'minitest-matchers'
require 'minitest/hell'
require 'pry-rescue/minitest' if ENV['RESCUE']
require 'webmock/minitest'

# Inclusions: First matchers, then modules, then helpers.
# Helpers need to be included after modules due to interdependencies.
Dir[Rails.root.join('test/support/modules/*.rb')].each { |f| require f }
Dir[Rails.root.join('test/support/spec_helpers/*.rb')].each { |f| require f }
Dir[Rails.root.join('test/objects/*.rb')].each { |f| require f }

# ~Disable logging for test performance!
# Change this value if you really need the log and run your suite again~
Rails.logger.level = 4

### Test Setup ###
File.open(Rails.root.join('log/test.log'), 'w') { |f| f.truncate(0) } # clearlog

Minitest.after_run do
  if $suite_passing
    rubocop
    rails_best_practices
  end
end

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # require 'enumerize/integrations/rspec'
  # extend Enumerize::Integrations::RSpec

  fixtures :all

  before :each do
    WebStubs.enable
    # DatabaseCleaner.start
  end

  after :each do
    # DatabaseCleaner.clean
    $suite_passing = false if failure
  end

  # Add more helper methods to be used by all tests here...
end

class MiniTest::Spec
  # before :each do
  #   DatabaseCleaner.start
  # end

  after :each do
    # DatabaseCleaner.clean
    $suite_passing = false if failure
  end

  # Add more helper methods to be used by all tests here...
end

$suite_passing = true
