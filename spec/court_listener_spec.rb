require "spec_helper"

describe CourtListener do
  context "CourtListener::Version" do
    it "must be defined" do
      expect(CourtListener::VERSION).not_to be_nil
    end
  end

  context "API endpoints" do
    it "contains the correct api base url" do
      expect(CourtListener::BASE_URL).to eq(
        "https://www.courtlistener.com/api/rest/v1/")
    end
    it "sets the proper API endpoints" do
      expect(CourtListener::Citation::ENDPOINT).to      eq("citation/")
      expect(CourtListener::CitedBy::ENDPOINT).to       eq("cited-by/")
      expect(CourtListener::Cites::ENDPOINT).to         eq("cites/")
      expect(CourtListener::Coverage::ENDPOINT).to      eq("coverage/")
      expect(CourtListener::Jurisdiction::ENDPOINT).to  eq("jurisdiction/")
      expect(CourtListener::Opinion::ENDPOINT).to       eq("opinion/")
      expect(CourtListener::Search::ENDPOINT).to        eq("search/")
    end

    it "contains all available endpoints" do
      expect(CourtListener.endpoints).to eq(
        ["citation", "cited-by", "cites", "coverage", "jurisdiction", "opinion", "search"])
    end

    it "are all valid" do
      WebMock.allow_net_connect!
      VCR.turned_off do
        expect(CourtListener::Citation.schema.response.code).to     eq("200")
        expect(CourtListener::CitedBy.schema.response.code).to      eq("200")
        expect(CourtListener::Cites.schema.response.code).to        eq("200")
        expect(CourtListener::Opinion.schema.response.code).to      eq("200")
        expect(CourtListener::Jurisdiction.schema.response.code).to eq("200")
        expect(CourtListener::Search.schema.response.code).to       eq("200")
      end
    end
  end

end
