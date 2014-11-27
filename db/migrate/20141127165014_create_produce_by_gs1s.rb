class CreateProduceByGs1s < ActiveRecord::Migration
  def change
    create_table :produce_by_gs1s do |t|
      t.belongs_to :produce_by_plu
      t.string :location
      t.text  :peticides_chemicals

      t.timestamps
    end
  end
end
