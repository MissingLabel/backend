class ItemsController < ApplicationController

  protect_from_forgery except: :json_object

  def json_object
    item = ProduceByPlu.find_by(plu_num: params[:plu_number])
    nutrition = NutritionApi.new(item.ndb_no)
    @produce_item = nutrition.prettify_api_info

    respond_to do |format|
      format.json { render :json => @produce_item }
    end
  end

end

