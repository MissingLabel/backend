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
      puts "Plu conditional"
      @plu_number = params[:number]
      @item = plu_item(@plu_number)
    else
      puts "GS1 conditional"
      @gs1_number = params[:number]
      @gs1_number = @gs1_number.to_s
      @item = ProduceByGs1.find_by(gs1_number: @gs1_number)
    end

    if @item == nil
      @produce_item = "Invalid input "
    else
      nutrition = NutritionApi.new(@item.ndb_no) if @plu_number
      nutrition = NutritionApi.new(@item.produce_by_plu.ndb_no) if @gs1_number
      @produce_item = nutrition.prettify_api_info
      puts "-------------"
      p @produce_item
      puts "-------------"
      @produce_item = organic_or_gmo(@number, @produce_item) if @plu_number

      @produce_item[:plu_no] = @plu_number if @plu_number
      @produce_item[:plu_no] = @item.produce_by_plu.plu_number if @gs1_number
      if @gs1_number 
        @produce_item[:variety] = @item.produce_by_plu.variety if @item.produce_by_plu.variety
        @produce_item[:farm_geo_location] = farm_geo_api(@item.location.address)
      else
        @produce_item[:variety] = @item.variety if @item.variety
      end
    end

    render :json => @produce_item
  end

end
