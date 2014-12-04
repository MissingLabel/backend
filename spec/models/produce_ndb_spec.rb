require 'rails_helper'

describe ProduceNdb do

  let!(:ndb_check) {ProduceNdb.new("http://www.thefruitpages.com/chartavocado.shtml")}


  describe "get_ndb_no" do

    it "should scrape site and return correct ndb number" do
      expect(ndb_check.get_ndb_no).to eq("09037")
    end
  end
end