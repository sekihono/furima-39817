class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
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
    if !user_signed_in?
      redirect_to new_user_session_path
    elsif unless current_user == @item.user
      # ユーザーが自身が出品した商品でない場合、トップページにリダイレクト
          redirect_to root_path
          end
    end
  end
  
  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit,status: :unprocessable_entity
    end
  end
  
  def destroy
    if !user_signed_in?
      redirect_to new_user_session_path
    elsif unless current_user == @item.user
      # ユーザーが自身が出品した商品でない場合、トップページにリダイレクト
          redirect_to root_path
          end
    else      
      @item.destroy
      redirect_to root_path
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:product_name, :description, :price, :image, :category_id, :product_status_id, :shipping_cost_burden_id, :origin_region_id, :delivery_time_id).merge(user_id: current_user.id)
  end
end
