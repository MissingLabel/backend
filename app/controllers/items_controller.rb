class ItemsController < ApplicationController

  protect_from_forgery except: :json_object

  def json_object
    @original_plu_num = params[:plu_nummber]
    @plu_nummer = params[:plu_nummber]
    if @plu_number.length == 5
      @plu_number = @plu_number[1..-1]
    end

    item = ProduceByPlu.find_by(plu_num: @plu_number)
    nutrition = NutritionApi.new(item.ndb_no)
    @produce_item = nutrition.prettify_api_info

    @produce_item = organic_or_gmo(@original_plu_number, @produce_item)

    respond_to do |format|
      format.json { render :json => @produce_item }
    end
  end

end

