require "court_listener"
require "vcr"
require "webmock/rspec"

RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  if config.files_to_run.one?
    config.default_formatter = "doc"
  end

  config.order = :random
  Kernel.srand config.seed

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end

  VCR.configure do |c|
    c.cassette_library_dir = "spec/vcr_cassettes"
    c.hook_into :webmock
  end

  def configure_username_password
    CourtListener.configure do |config|
      config.username = 'spuiszis'
      config.password = 'password123!'
    end
  end
end
