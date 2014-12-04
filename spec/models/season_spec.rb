require 'rails_helper'

describe Season do
  let(:winter) { Season.new(name: "Winter") }
  let(:apple)  	{ProduceByPlu.create!(plu_number: 3283, 
  									ndb_no: "09003", 
  									commodity: "apples", 
  									variety: "honeycrisp", 
  									size: 'large', 
  									how_to_store: "Refrigerate apples in plastic bag away from stron...", 
  									how_to_select: " Choose firm, shiny, smooth-skinned apples with in...")}


  context "#initialize" do
    it 'should have valid first name' do
      winter.save
      expect(winter.name).to eq("Winter")
    end

    it 'should have SeasonalFruits' do
      winter.save
      apple.seasons << winter
      expect(winter.seasonal_fruits.first).to be_an_instance_of SeasonalFruit
  	end

  	it 'should have ProduceByPlus' do
      winter.save
      apple.seasons << winter
      expect(winter.produce_by_plus.first).to be_an_instance_of ProduceByPlu
  	end
  end

end
