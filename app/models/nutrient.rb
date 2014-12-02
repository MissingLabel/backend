class Nutrient
  def initialize(name, units, num, dv)
    @name = name
    @units = units
    @num = num
    @dv = dv
    @per = ((num.to_f / dv) * 100).round)
  end

  def to_hash
    {units: @units, name: @name, per: @per, num: @num}
  end

  def self.from_usda_node(name, node, dv)
    Nutrient.new(name,
                 node['unit'],
                 node['valueper100g'],
                 dv)
  end
end
