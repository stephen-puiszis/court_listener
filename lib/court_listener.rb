require_relative "court_listener/version"
require_relative "court_listener/configuration"
require_relative "court_listener/exception"
require_relative "court_listener/request"
require_relative "court_listener/response"
require_relative "court_listener/endpoints/jurisdiction"
require_relative "court_listener/endpoints/search"
require_relative "court_listener/endpoints/opinion"
require_relative "court_listener/endpoints/citation"
require_relative "court_listener/endpoints/coverage"
require_relative "court_listener/endpoints/cites"
require_relative "court_listener/endpoints/cited_by"

module CourtListener
  extend CourtListener::Jurisdiction
  extend CourtListener::Search
  extend CourtListener::Opinion
  extend CourtListener::Citation
  extend CourtListener::Coverage
  extend CourtListener::Cites
  extend CourtListener::CitedBy

  class << self
    attr_accessor :configuration
  end

  BASE_URL = "https://www.courtlistener.com/api/rest/v1/".freeze

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.endpoints
    endpoints = Dir.entries("lib/court_listener/endpoints").keep_if{|val| val !~ /(\A\.{1,2}\z)/}
    endpoints.map{|e| e.gsub(/(.rb\z|_)/, ".rb" => "", "_" => "-")}.freeze
  end
end
