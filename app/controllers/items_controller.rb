class ItemsController < ApplicationController

  protect_from_forgery except: :json_object

  def json_object
    print params
    @number = params[:number]

    if @number.length < 6
      @plu_number = params[:number]
      @item = plu_item(@plu_number)
    else
      @gs1_number = params[:number]
      @gs1_number = @gs1_number.to_s
      @item = ProduceByGs1.find_by(gs1_number: @gs1_number).produce_by_plu
    end

    if @item == nil
      @produce_item = "Invalid input "
    else
      nutrition = NutritionApi.new(@item.ndb_no)
      @produce_item = nutrition.prettify_api_info

      @produce_item = organic_or_gmo(@number, @produce_item)

      @produce_item[:plu_no] = @plu_number
      @produce_item[:variety] = @item.variety
      @produce_item[:farm_geo_location] = farm_geo_api(@gs1_number.location.address) if @gs1_number
    end

    render :json => @produce_item
  end

end
