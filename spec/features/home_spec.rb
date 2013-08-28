require 'spec_helper'

describe "Home", :type => :request do

  describe "GET /" do
    it "sets secure headers (X-Frame-Options & X-XSS-Protection)" do
      # NOTE: the app also sets X-Content-Type-Options: nosniff, but that is only set for IE browsers
      visit root_path
      
      expect(page.response_headers["X-Frame-Options"]).to eq "DENY"
      expect(page.response_headers["X-XSS-Protection"]).to eq "1; mode=block"
    end
  end
end
