class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.belongs_to :produce_by_gs1
      t.string :name
      t.string :address
      t.timestamps
    end
  end
end
