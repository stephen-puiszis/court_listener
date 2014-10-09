module CourtListener
  module CitedBy

    ENDPOINT = "cited-by/".freeze

    def self.find(id, params = {})
      params["id"] = id
      CourtListener::Request.new(ENDPOINT, params)
    end

    def self.schema
      CourtListener::Request.new(ENDPOINT + "schema/")
    end

  end
end
