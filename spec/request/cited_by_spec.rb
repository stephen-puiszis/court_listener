require 'spec_helper'

describe CourtListener::CitedBy do
  describe "#schema" do
    before { configure_username_password }
    let(:request) { CourtListener::CitedBy.schema }

    it "returns the cited by endpoint schema" do
      VCR.use_cassette 'cited_by/schema' do
        expect(request.response.code).to eq('200')
        expect(request.response.data).to include("fields")
        expect(request.response.data["fields"]).to_not be_nil
      end
    end
  end
end
