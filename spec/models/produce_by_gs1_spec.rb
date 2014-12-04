require 'rails_helper'

describe ProduceByPlu do
  let(:eggplants_by_plu){ProduceByPlu.create!(plu_number: 4599, ndb_no: "11209", 
                                       commodity: "eggplant", 
                                       variety: "baby", size: nil, 
                                       how_to_store: "Store eggplants in the refrigerator crisper drawe...", 
                                       how_to_select: "Choose eggplants that are heavy for their size an...")}
  
  let(:eggplants_farm) {Location.create!(name: "Riverfront Berry Farm", 
                                          address: "2799 N. 1700 East Rd. Martinton, IL 60951")}
  
  let(:eggplants_by_gs1) {ProduceByGs1.new(gs1_number: "00856122001872", 
                                            pesticides_chemicals: "true",
                                            produce_by_plu: eggplants_by_plu,
                                            )}

  context "#initialize" do
    it 'should have a valid gs1 number' do
      eggplants_by_gs1.save!
      expect(eggplants_by_gs1.gs1_number).to eq("00856122001872")
    end

    it 'should have a value for pesticides and chemicals' do
      eggplants_by_gs1.save!
      expect(eggplants_by_gs1.pesticides_chemicals).to eq("true")
    end

    it "should belong to a ProduceByPlu " do
      eggplants_by_gs1.save!
      expect(eggplants_by_gs1.produce_by_plu).to be_an_instance_of ProduceByPlu
    end

    pending "should belong to a Location " do
      # eggplants_by_gs1.save!
      # eggplants_by_gs1.update(location: )
      # expect(eggplants_by_gs1.location).to be_an_instance_of Location
    end
  end
end