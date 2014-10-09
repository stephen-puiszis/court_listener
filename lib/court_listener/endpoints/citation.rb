module CourtListener
  module Citation

    ENDPOINT = "citation/".freeze

    def self.schema
      CourtListener::Request.new("#{ENDPOINT}schema/")
    end

    def self.searchable_fields
      CourtListener::Search.schema.data["fields"].keys
    end

    def self.filterable_fields
      CourtListener::Search.schema.data["filtering"].keys
    end

    def self.orderable_fields
      CourtListener::Search.schema.data["ordering"]
    end

  end
end
