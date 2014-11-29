class ItemsController < ApplicationController
  
  protect_from_forgery except: :json_object
  
  def json_object

    if request.xhr?
      @produce_item = ProduceByPlu.find_by(plu_number: params[:plu_number])
      @json_produce_item = {commodity: @produce_item.commodity,
                            variety: @produce_item.variety}.to_json
    end

  end

end
