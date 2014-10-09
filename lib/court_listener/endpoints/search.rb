module CourtListener
  module Search

    ENDPOINT = "search/".freeze

    def self.new(query, params = {})
      params["q"]                 = query
      params["order_by"]          ||= "score desc"
      params["stat_Precedential"] ||= "on"
      CourtListener::Request.new(ENDPOINT, params)
    end

    def self.sha_query(sha_key, params = {})
      params["q"] = sha_key
      CourtListener::Request.new(ENDPOINT, params)
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

  end
end
