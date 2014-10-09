require 'spec_helper'

describe CourtListener::Cites do
  describe "#schema" do
    before { configure_username_password }
    let(:request) { CourtListener::Cites.schema }

    it "returns the cites endpoint schema" do
      VCR.use_cassette 'cites/schema' do
        expect(request.response.code).to eq('200')
        expect(request.response.data).to include("fields")
        expect(request.response.data["fields"]).to_not be_nil
      end
    end
  end
end
