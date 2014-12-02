module ItemsHelper

  def plu_item(plu_number)
      if plu_number.length == 5
        plu_number = plu_number[1..-1]
        item = ProduceByPlu.find_by(plu_number: plu_number)
      else
        item = ProduceByPlu.find_by(plu_number: plu_number)
      end
      item
  end

  def organic_or_gmo(plu_number, produce_item)
    if @plu_number.length == 5
      if @plu_number[0] == 8
        @produce_item[:gmo] = "True"
        @produce_item[:oraganic] = "False"
      else @plu_number[0] == 9
        @produce_item[:gmo] = "False"
        @produce_item[:oraganic] = "True"
      end
    else
      @produce_item[:gmo] = "False"
      @produce_item[:oraganic] = "False"
    end
    @produce_item
  end

  def farm_geo_api(farm_address)
    farm_address.split(" ").join("+")
  end

end
