module ItemHelper


  def plu_or_gs1_item(@plu_number, @gs1_number)
    if @plu_number
      if @plu_number.length == 5
        @plu_number = @plu_number[1..-1]
      end
      item = ProduceByPlu.find_by(plu_number: @plu_number)
    else
      item = ProduceByGs1.find_by(gs1_number: @gs1_number).produce_by_plu
    end
    item
  end

  def organic_or_gmo(@plu_number, @produce_item)
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
