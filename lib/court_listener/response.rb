require 'json'

module CourtListener
  class Response

    attr_accessor :code, :raw, :meta_data, :data, :not_found

    def initialize(http_response)
      @code = http_response.code
      @raw  = http_response.body
      read_response(@raw)
    end

    def read_response(json)
      parsed      = JSON.parse(json)
      @meta_data  = parsed["meta"]
      @data       = parsed["objects"] || parsed
      @not_found  = parsed["not_found"] || nil
    end
  end
end
