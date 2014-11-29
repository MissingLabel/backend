class ProduceController < ApplicationController

  def index
    @all_produce = ProduceByPlu.all
  end

end
