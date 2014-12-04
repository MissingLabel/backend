require 'rails_helper'

describe ProduceByPlu do
  let(:apples) {ProduceByPlu.new(plu_number: 3283, 
                                    ndb_no: "09003", 
                                    commodity: "apples", 
                                    variety: "honeycrisp", 
                                    size: 'large', 
                                    how_to_store: "Refrigerate apples in plastic bag away from stron...", 
                                    how_to_select: " Choose firm, shiny, smooth-skinned apples with in...")}
  let(:winter) { Season.new(name: "Winter") }

  context "#initialize" do
    it 'should have a valid plu number' do
      apples.save
      expect(apples.plu_number).to eq(3283)
    end

    pending 'should have a valid ndb number' do
      # apples.save
      # expect(apple.ndb_no).to eq("09003")
    end

    it 'should have valid commodity' do
      apples.save
      expect(apples.commodity).to eq("apples")
    end

    it 'should have seasons' do
      apples.save
      apples.seasons << winter
      expect(apples.seasons.first).to be_an_instance_of Season
    end
  end
end
