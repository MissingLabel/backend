require 'rails_helper'

describe User do
  let(:eggplants_farm) {Location.new(name: "Riverfront Berry Farm", 
  											address: "2799 N. 1700 East Rd. Martinton, IL 60951")}
  let(:bad_location) {Location.new(name: "", 
  											address: "")}

  context "#initialize" do
    it 'should have valid name' do
      eggplants_farm.save
      expect(eggplants_farm.name).to eq("Riverfront Berry Farm")
    end

    it 'should have valid address' do
      eggplants_farm.save
      expect(eggplants_farm.address).to eq("2799 N. 1700 East Rd. Martinton, IL 60951")
    end

    it 'should be an invalid user object when bad input is given' do
      bad_location.save
      expect(bad_location).to be_invalid
    end
  end
end
