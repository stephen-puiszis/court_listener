require "spec_helper"

describe CourtListener::Response do
   describe "#read_request happy path" do
    let(:request) do
      configure_username_password
      CourtListener::Jurisdiction.all
    end

    it "sets request code" do
      VCR.use_cassette 'jurisdiction/valid' do
        expect(request.response.code).to eq("200")
      end
    end

    it "sets raw data" do
      VCR.use_cassette 'jurisdiction/valid' do
        expect(request.response.raw).to be_an_instance_of(String)
        expect(request.response.raw).to_not be_nil
      end
    end

    it "sets meta_data" do
      VCR.use_cassette 'jurisdiction/valid' do
        expect(request.response.meta_data).to be_an_instance_of(Hash)
        expect(request.response.meta_data).to_not be_nil
      end
    end

    it "sets data" do
      VCR.use_cassette 'jurisdiction/valid' do
        expect(request.response.data).to be_an_instance_of(Array)
        expect(request.response.data).to_not be_nil
        expect(request.response.data.length).to eq(355)
      end
    end
  end

  describe "#read_request fallback" do
    before { configure_username_password }
    let(:search_value) {'abc'}
    let(:no_results) { CourtListener::Jurisdiction.find(search_value) }

    it "falls back if data is not found" do
      VCR.use_cassette 'jurisdiction/valid_no_results' do
        expect(no_results.response.data.length).to eq(0)
        expect(no_results.response.not_found).to include(search_value)
        expect(no_results.response.code).to eq("200")
      end
    end
  end
end
