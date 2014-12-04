require 'rails_helper'

describe Season do
  let(:winter) { Season.create!(name: "Winter") }
  let(:apple)  	{ProduceByPlu.create!(plu_number: 3283, 
  									ndb_no: "09003", 
  									commodity: "apples", 
  									variety: "honeycrisp", 
  									size: 'large', 
  									how_to_store: "Refrigerate apples in plastic bag away from stron...", 
  									how_to_select: " Choose firm, shiny, smooth-skinned apples with in...")}
  let(:seasonal_apple) {SeasonalFruit.create!(season: winter, produce_by_plu: apple)}


  context "#initialize" do

    it 'should belong to a Season' do
      expect(seasonal_apple.season).to be_an_instance_of Season
  	end

  	it 'should belong to a ProduceByPlu' do
      expect(seasonal_apple.produce_by_plu).to be_an_instance_of ProduceByPlu
  	end
  end

end