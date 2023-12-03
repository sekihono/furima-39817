class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :destroy]
  before_action :move_to_top, only: [:show]

  def index
    @items = Item.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    binding.pry
    if @item.save  
      redirect_to root_path
    else
      puts @item.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end
  
  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit,status: :unprocessable_entity
    end
  end
  
  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:product_name, :description, :price, :image, :category_id, :product_status_id, :shipping_cost_burden_id, :origin_region_id, :delivery_time_id).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index 
    if current_user != @item.user
      # ユーザーが自身が出品した商品でない場合、トップページにリダイレクト
          redirect_to root_path
    end
  end

  def move_to_top 
    @item = Item.find(params[:id])
    #binding.pry
    if current_user == @item.user &&  @item.sold_out? 
      # ユーザーが自身が出品した商品 かつ売却済みの商品の場合、トップページにリダイレクト
          redirect_to root_path
    end
  end

end

