class SeasonalFruit < ActiveRecord::Base
  belongs_to :season
  belongs_to :produce_by_plu
end
