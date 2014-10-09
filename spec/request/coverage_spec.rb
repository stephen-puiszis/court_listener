require 'spec_helper'

describe CourtListener::Coverage do
  describe "#all" do
    before { configure_username_password }
    let(:request) { CourtListener::Coverage.all }

    it "returns all coverage" do
      VCR.use_cassette 'coverage/all' do
        expect(request.response.code).to eq('200')
        expect(request.response.data).to_not be_nil
      end
    end
  end

  describe "#find one" do
    before { configure_username_password }
    let(:request) { CourtListener::Coverage.find("ca9")}

    it "returns the requested coverage" do
      VCR.use_cassette 'coverage/find_one' do
        expect(request.response.code).to eq('200')
        expect(request.response.data.length).to_not be_nil
      end
    end
  end

  describe "#paramterize_codes" do
    before { configure_username_password }
    let(:request) { CourtListener::Coverage.find({"scotus" => true})}

    it "raises an error if an invalid parameter is used" do
      VCR.use_cassette 'coverage/invalid_parameters' do
        expect{request}.to raise_error
      end
    end
  end
end
