module CourtListener
  module Opinion

    ENDPOINT = "opinion/".freeze

    def self.find(params = {})
      CourtListener::Request.new(ENDPOINT, params)
    end

    def self.find_by_id(id, params = {})
      path = CourtListener::Opinion.parameterize_codes(id)
      CourtListener::Request.new(path, params)
    end

    def self.schema
      CourtListener::Request.new(ENDPOINT + "schema/")
    end

    def self.searchable_fields
      CourtListener::Search.schema.response.data["fields"].keys
    end

    def self.filterable_fields
      CourtListener::Search.schema.response.data["filtering"].keys
    end

    def self.orderable_fields
      CourtListener::Search.schema.response.data["ordering"]
    end

    private

    def self.parameterize_codes(codes)
      case codes
        when String then return ENDPOINT + codes + "/"
        when Integer  then return ENDPOINT + codes.to_s + "/"
        when Array  then return ENDPOINT + codes.flatten.join(";") + "/"
        else raise "Invalid format, please submit a string or an array of strings"
      end
    end

  end
end
