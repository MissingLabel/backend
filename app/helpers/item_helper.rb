module ItemHelper

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
