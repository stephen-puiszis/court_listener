require "spec_helper"

describe CourtListener::Configuration do

  describe "#configure" do
    before do
      CourtListener.configure do |config|
        config.username = 'exampleuser'
        config.password = 'examplepassword'
      end
    end

    it "sets username and password" do
      expect(CourtListener.configuration.username).to eq('exampleuser')
      expect(CourtListener.configuration.password).to eq('examplepassword')
    end
  end

end
