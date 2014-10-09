require 'spec_helper'

describe CourtListener::Citation do
  describe "#schema" do
    before { configure_username_password }
    let(:request) { CourtListener::Citation.schema }

    it "returns the citation endpoint schema" do
      VCR.use_cassette 'citation/schema' do
        expect(request.response.code).to eq('200')
        expect(request.response.data).to include("fields")
        expect(request.response.data["fields"]).to_not be_nil
      end
    end
  end

end
