class CreateSeasonalFruits < ActiveRecord::Migration
  def change
    create_table :seasonal_fruits do |t|
      t.belongs_to :season
      t.belongs_to :produce_by_plu

      t.timestamps
    end
  end
end
