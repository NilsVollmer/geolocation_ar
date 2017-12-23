# frozen_string_literal: true

namespace :test do
  desc 'Run a Rubocop code style check'
  task :rubocop do
    system 'rubocop --format json'
  end
end
