require 'spec_helper'

describe CourtListener::Jurisdiction do
  describe "#all" do
    before { configure_username_password }
    let(:request) { CourtListener::Jurisdiction.all }

    it "returns every jurisdiction" do
      VCR.use_cassette 'jurisdiction/all' do
        expect(request.response.code).to eq('200')
        expect(request.response.data.length).to eq(355)
      end
    end
  end

  describe "#find multiple by string" do
    before { configure_username_password }
    let(:request) { CourtListener::Jurisdiction.find("scotus")}

    it "returns the requested jurisdiction" do
      VCR.use_cassette 'jurisdiction/find_one' do
        expect(request.response.code).to eq('200')
        expect(request.response.data.length).to eq(1)
        expect(request.response.data[0]["id"]).to eq("scotus")
      end
    end
  end

  describe "#find multiple by array" do
    before { configure_username_password }

    let(:request) { CourtListener::Jurisdiction.find(["scotus", "ca1", "ca2", "ca3"]) }

    it "returns the requested jurisdictions" do
      VCR.use_cassette 'jurisdiction/find_multiple' do
        expect(request.response.code).to eq('200')
        expect(request.response.data.length).to eq(4)
        expect(request.response.data[0]["id"]).to eq("scotus")
      end
    end
  end

  describe "#schema" do
    before { configure_username_password }
    let(:request) { CourtListener::Jurisdiction.schema }

    it "returns the jurisdiction endpoint schema" do
      VCR.use_cassette 'jurisdiction/schema' do
        expect(request.response.code).to eq('200')
        expect(request.response.data).to include("fields")
        expect(request.response.data["fields"]).to_not be_nil
      end
    end
  end

  describe "#paramterize_codes" do
    before { configure_username_password }
    let(:request) { CourtListener::Jurisdiction.find({"scotus" => true})}

    it "raises an error if an invalid parameter is used" do
      VCR.use_cassette 'jurisdiction/invalid_parameters' do
        expect{request}.to raise_error
      end
    end
  end
end
