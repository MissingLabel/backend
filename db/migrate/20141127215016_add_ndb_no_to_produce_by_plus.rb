class AddNdbNoToProduceByPlus < ActiveRecord::Migration
  def change
    add_column :produce_by_plus, :ndb_no, :string
  end
end