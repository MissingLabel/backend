class ProduceByGs1 < ActiveRecord::Base
  belongs_to :produce_by_plu
  belongs_to :location

    validates_presence_of :pesticides_chemicals, :gs1_number
end	