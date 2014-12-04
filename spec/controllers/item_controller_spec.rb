require 'rails_helper'

RSpec.describe ItemsController, :type => :controller do

	describe "GET #show" do
    it "returns produce item as json" do
    # 	produce_item = {commodity: "apple",
    # 					variety: "Gala",
    # 					size: "small"}
    	xhr :get, "/show"
    	# get "/show", {}, {"Accept" => "application/json"}

    # 	expect(response.status).to eq 200
      # get :show #, { number: number.to_param }
      # expect(assigns(:number)).to eq(number)
    	end
    end
end
