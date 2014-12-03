require 'rails_helper'

describe NutritionApi do
  before(:each) do
    ProduceByPlu.create!(plu_number: 4599, ndb_no: "11209", commodity: "Eggplant", how_to_store: "Eat it really fast" )
  end
  let!(:eggplant) {NutritionApi.new("11209")}

  describe "Initialize" do

    it "should find the correct produce item by ndb_no" do
      expect(eggplant.produce.plu_number).to eq(4599)
    end
  end

  describe "make_api_url" do

    it "should create a url with the 'ndb_no' of the produce" do
      expect(eggplant.make_api_url).to eq("http://api.data.gov/usda/ndb/reports/?ndbno=11209&type=f&format=xml&api_key=T7Or56nDBNq3C6VdIJC47Sz1qxprwdyByquFaV4A")
    end
  end

  describe "prettify_api_info" do

    it "should return correct 'commodity' " do
      expect(eggplant.prettify_api_info[:name]).to eq("Eggplant")
    end

    it "should return correct number of 'calories'" do
      expect(eggplant.prettify_api_info[:calories]).to eq("25")
    end

    it "should contain a key 'lower_label' with value type array" do
      expect(eggplant.prettify_api_info[:lower_label]).to be_an_instance_of(Array)
    end

    it "should return correct units for 'Vitamin A'" do
      expect(eggplant.prettify_api_info[:lower_label][4][:units]).to eq("IU")
    end

    it "should return correct percentage for 'Potassium'" do
      expect(eggplant.prettify_api_info[:lower_label][3][:per]).to eq(7)
    end

    it "should return a key 'seasons' with value type string" do
      expect(eggplant.prettify_api_info[:seasons]).to be_an_instance_of(String)
    end

    it "should return the correct storage information" do
      expect(eggplant.prettify_api_info[:how_store]).to eq("Eat it really fast")
    end

  end

end