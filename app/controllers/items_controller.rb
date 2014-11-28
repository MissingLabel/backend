class ItemsController < ApplicationController

  def json
    @produce_item = ProduceByPlu.find_by(plu_number: params[:plu_number])
    @json_produce_item = {"Access-Control-Allow-Credentials" => true,
                          "Access-Control-Allow-Origin" => true,
                          commodity: @produce_item.commodity,
                          variety: @produce_item.variety}.to_json
  end


end
