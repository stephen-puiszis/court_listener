require 'spec_helper'

describe CourtListener::Search do
  describe "#new" do
    before { configure_username_password }
    let(:request) { CourtListener::Search.new("bank of america") }
    after { request = nil }

    it "returns something for a broad search" do
      VCR.use_cassette 'search/broad' do
        expect(request.response.code).to eq('200')
        expect(request.response.data).to_not be_nil
      end
    end
  end

  describe "#new with parameters" do
    before { configure_username_password }
    let(:parameters) { {"order_by" => "score desc"} }
    let(:request) { CourtListener::Search.new("USA", parameters) }
    after { request = nil }

    it "returns accepts a search with various parameters " do
      VCR.use_cassette 'search/broad-parameters' do
        expect(request.params).to include(parameters)
        expect(request.response.code).to eq('200')
        expect(request.response.data).to_not be_nil
      end
    end
  end

  describe "#sha_query" do
    before { configure_username_password }
    let(:sha_string) { "a2daab35251795fc2621c6ac46b6031c95a4e0ba" }
    let(:request) { CourtListener::Search.sha_query(sha_string) }
    after { request = nil }

    it "returns something for a valid sha key" do
      VCR.use_cassette 'search/sha_query' do
        expect(request.response.code).to eq('200')
        expect(request.response.data).to_not be_nil
        expect(request.response.data[0]["snippet"]).to include(sha_string)
      end
    end
  end

  describe "#schema" do
    before { configure_username_password }
    let(:request) { CourtListener::Search.schema }
    after { request = nil }

    it "returns the search endpoint schema" do
      VCR.use_cassette 'search/schema' do
        expect(request.response.code).to eq('200')
        expect(request.response.data).to include("fields")
        expect(request.response.data["fields"]).to_not be_nil
      end
    end
  end
end
