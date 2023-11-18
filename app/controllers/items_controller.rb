class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
    # binding.pry
    #@items = Item.all
  end
  def new
    @item = Item.new
  end

  def create
    #binding.pry
    @item = Item.new(item_params)
    # binding.pry
    if @item.save
      redirect_to root_path
    else
      puts @item.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end


  private

  def item_params
    params.require(:item).permit(:product_name, :description, :price, :image, :category_id, :product_status_id, :shipping_cost_burden_id, :origin_region_id, :delivery_time_id).merge(user_id: current_user.id)
  end

end
