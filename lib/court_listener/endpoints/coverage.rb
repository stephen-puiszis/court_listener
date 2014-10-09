module CourtListener
  module Coverage

    ENDPOINT = "coverage/".freeze

    # The Coverage endpoint does not have a schema response
    def self.all
      CourtListener::Request.new(ENDPOINT + "all/")
    end

    def self.find(jurisdiction_code, params = {})
      path = CourtListener::Coverage.parameterize_codes(jurisdiction_code)
      CourtListener::Request.new(path, params)
    end


    private

    def self.parameterize_codes(codes)
      case codes
        when String then return ENDPOINT + codes + "/"
        else raise "Invalid format, please submit a string"
      end
    end

  end
end
