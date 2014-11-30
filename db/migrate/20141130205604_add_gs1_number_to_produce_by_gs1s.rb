class AddGs1NumberToProduceByGs1s < ActiveRecord::Migration
  def change
    add_column :produce_by_gs1s, :gs1_number, :string
  end
end
