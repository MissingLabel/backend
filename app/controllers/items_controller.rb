class ItemsController < ApplicationController

  protect_from_forgery except: :json_object

  def json_object
    @number = params[:number]

    if @number.length < 6
      @plu_number = params[:number]
    else
      @gs1_number = params[:number]
    end

    # @item = plu_or_gs1_item(@plu_number, @gs1_number)

    if @plu_number
      if @plu_number.length == 5
        @plu_number = @plu_number[1..-1]
      end
      @item = ProduceByPlu.find_by(plu_number: @plu_number)
    else
      @item = ProduceByGs1.find_by(gs1_number: @gs1_number).produce_by_plu
    end

    nutrition = NutritionApi.new(@item.ndb_no)
    @produce_item = nutrition.prettify_api_info

    # @produce_item = organic_or_gmo(@number, @produce_item)

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

    respond_to do |format|
      format.json { render :json => @produce_item }
    end
  end

end
