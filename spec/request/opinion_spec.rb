require 'spec_helper'

describe CourtListener::Opinion do
  describe "#find without params" do
    before { configure_username_password }
    let(:request) { CourtListener::Opinion.find }
    after { request = nil }

    it "returns something for a valid ID" do
      VCR.use_cassette 'opinion/find_no_params' do
        expect(request.response.code).to eq('200')
        expect(request.response.data).to_not be_nil
        expect(request.response.meta_data['next']).to_not be_nil
        expect(request.response.meta_data['total_count']).to be > 100_000
      end
    end
  end

  describe "#find with params" do
    before { configure_username_password }
    let(:search_params) {
      {"court" => "scotus", "suit_nature" => "fraud"} }
    let(:request) { CourtListener::Opinion.find(search_params) }
    after { request = nil }

    it "returns something for a valid ID" do
      VCR.use_cassette 'opinion/find_with_params' do
        expect(request.response.code).to eq('200')
        expect(request.response.data).to_not be_nil
      end
    end
  end

  describe "#find_by_id" do
    before { configure_username_password }
    let(:request) { CourtListener::Opinion.find_by_id(111170) }
    after { request = nil }

    it "returns something for a valid ID" do
      VCR.use_cassette 'opinion/single_id' do
        expect(request.response.code).to eq('200')
        expect(request.response.data).to_not be_nil
      end
    end
  end

  describe "#schema" do
    before { configure_username_password }
    let(:request) { CourtListener::Opinion.schema }
    after { request = nil }

    it "returns the opinion endpoint schema" do
      VCR.use_cassette 'opinion/schema' do
        expect(request.response.code).to eq('200')
        expect(request.response.data).to include("fields")
        expect(request.response.data["fields"]).to_not be_nil
      end
    end
  end
end
