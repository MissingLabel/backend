class RemoveLocationFromProduceByGs1s < ActiveRecord::Migration
  def change
    remove_column :produce_by_gs1s, :location, :string
    add_column :produce_by_gs1s, :location, :integer
  end
end
