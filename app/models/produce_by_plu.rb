class ProduceByPlu < ActiveRecord::Base
  has_many :produce_by_gs1s
  has_many :seasonal_fruits
  has_many :seasons, through: :seasonal_fruits
end
