class CreateProduceByPlus < ActiveRecord::Migration
  def change
    create_table :produce_by_plus do |t|
      t.integer :plu_number
      t.string :ndb_no
      t.string :commodity
      t.string :variety
      t.string :size
      t.text :how_to_store
      t.text :how_to_select

      t.timestamps
    end
  end
end
