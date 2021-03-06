class Season < ActiveRecord::Base
  has_many :seasonal_fruits
  has_many :produce_by_plus, through: :seasonal_fruits

  validates_presence_of :name
end
