class ProduceByPlusController < ApplicationController

  def show
    @produce_item = ProduceByPlu.find_by(plu_number: params[:plu_num])
    @json_produce_item = {commodity: @produce_item.commodity,
                          variety: @produce_item.variety}.to_json
  end


end
