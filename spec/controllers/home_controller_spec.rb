require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'search'" do
    it "returns http success" do
      stub_request(:post, "http://www2.fdic.gov/funds/unclaimresponse.asp").
        with(:body => "source=saveForm&ValidForm=true&NameErr=0&R1=&TypeErr=0&St=NONE&StateErr=0&SrchStr=&SrchErr=0&SrchName=Miller").
          to_return(:status => 200, :body => "", :headers => {})

      stub_request(:post, "http://search.pbgc.gov/mp/results.aspx").
        with(:body => "commandAction=indvSearch1&wc1=exact&company1=&wc2=contains&state1=0&lname1=").
          to_return(:status => 200, :body => "", :headers => {})

      stub_request(:post, "http://www.hud.gov/offices/hsg/comp/refunds/refundlist.cfm").
        with(:body => "case_num=&idx=0&rangestart=1&recordcount=0&rangeend=0&groupsize=30&called_from=page1&search=Search&f_name=").
          to_return(:status => 200, :body => "", :headers => {})

      get 'search'

      response.should be_success
    end
  end

end
