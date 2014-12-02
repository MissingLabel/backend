class CreateProduceByGs1s < ActiveRecord::Migration
  def change
    create_table :produce_by_gs1s do |t|
   	  t.string :gs1_number
      t.text  :pesticides_chemicals
      t.belongs_to :produce_by_plu
      t.belongs_to :location

      t.timestamps
    end
  end
end
