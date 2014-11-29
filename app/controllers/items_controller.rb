class ItemsController < ApplicationController

  protect_from_forgery except: :json_object

  def json_object
    @produce_item = ProduceByPlu.find_by(plu_number: params[:plu_number])
    respond_to do |format|
      format.json { render :json => @produce_item }
    end
  end

end

