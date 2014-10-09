module CourtListener
  module Jurisdiction

    ENDPOINT = "jurisdiction/".freeze

    def self.all(params = {})
      params[:limit] ||= "355"
      CourtListener::Request.new(ENDPOINT, params)
    end

    # Accepts a jurisdiction code String or an Array of jurisidction code strings
    def self.find(jurisdiction_codes, params = {})
      path = CourtListener::Jurisdiction.parameterize_codes(jurisdiction_codes)
      CourtListener::Request.new(path, params)
    end

    def self.schema
      CourtListener::Request.new(ENDPOINT + "schema/")
    end

    def self.data_fields
      CourtListener::Request.schema.response.data["fields"].keys
    end

    def self.filterable_fields
      CourtListener::Jurisdiction.schema.response.data["filtering"].keys
    end

    def self.orderable_fields
      CourtListener::Jurisdiction.schema.response.data["ordering"]
    end

    private


    def self.parameterize_codes(codes)
      case codes
        when String then return ENDPOINT + "set/" + codes + "/"
        when Array  then return ENDPOINT + "set/" + codes.flatten.join(";") + "/"
        else raise "Invalid format, please submit a string or an array of strings"
      end
    end

  end
end
