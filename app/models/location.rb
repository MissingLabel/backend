class Location < ActiveRecord::Base
  has_many :produce_by_gs1

  validates_presence_of :name, :address
  
end
