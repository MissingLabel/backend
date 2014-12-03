class ItemsController < ApplicationController

  protect_from_forgery except: :json_object

  def json_object
    p params
    puts "-------------"
    p params[:number]
    @number = params[:number]
    puts "-------------"
    puts @number.length
    puts "-------------"

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

      @produce_item = organic_or_gmo(@number, @produce_item) if @plu_number

      @produce_item[:plu_no] = @plu_number if @plu_number
      @produce_item[:plu_no] = @item.plu_number if @gs1_number 
      @produce_item[:variety] = @item.variety if @item.variety
      @produce_item[:farm_geo_location] = farm_geo_api(@item.location.address) if @gs1_number
    end

    render :json => @produce_item
  end

end
