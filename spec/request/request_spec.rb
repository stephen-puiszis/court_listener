require "spec_helper"

describe CourtListener::Request do
  describe "#initialize" do
    WebMock.allow_net_connect!
    let(:request) { CourtListener::Jurisdiction.all(limit: "1") }

    it "sets path" do
      VCR.turned_off do
        expect(request.path).to eq("jurisdiction/")
      end
    end

    it "sets url params" do
      VCR.turned_off do
        expect(request.params).to eq( {limit: "1", format: "json"} )
      end
    end
  end
end
