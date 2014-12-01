class ItemsController < ApplicationController

  protect_from_forgery except: :json_object

  def json_object
    print params
    @number = params[:number]

    if @number.length < 6
      @plu_number = params[:number]
    else
      @gs1_number = params[:number]
    end

    @item = plu_or_gs1_item(@plu_number, @gs1_number)

    nutrition = NutritionApi.new(@item.ndb_no)
    @produce_item = nutrition.prettify_api_info

    @produce_item = organic_or_gmo(@number, @produce_item)
    @produce_item[:plu_number] = @plu_number

    render :json => @produce_item
  end

end
