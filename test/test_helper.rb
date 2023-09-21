require 'simplecov'

if ENV['CI']
  SimpleCov.start('rails') do
    if ENV['COVERAGE']
      require 'simplecov-lcov'

      SimpleCov::Formatter::LcovFormatter.config do |c|
        c.report_with_single_file = true
        c.single_report_path = 'coverage/lcov.info'
      end

      formatter SimpleCov::Formatter::LcovFormatter

    end

    add_filter ['version.rb', 'initializer.rb', 'config.rb']
  end
end

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'sidekiq/testing'
Sidekiq::Testing.inline!

class ActiveSupport::TestCase
  include ActionMailer::TestHelper
  include AuthHelper
  # Run tests in parallel with specified workers
  ENV['RAILS_ENV'] || parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  include FactoryBot::Syntax::Methods

  def after_teardown
    super

    remove_uploaded_files
  end

  def remove_uploaded_files
    FileUtils.rm_rf(ActiveStorage::Blob.service.root)
  end
end
