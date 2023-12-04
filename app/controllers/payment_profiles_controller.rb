class PaymentProfilesController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :set_item, only: [:index, :create]
  before_action :move_to_index, only: [:index]


  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @payment_profiles_shippings = PaymentProfilesShippings.new
  end

  def create
    @payment_profiles_shippings = PaymentProfilesShippings.new(payment_profiles_shippings_params)
    if @payment_profiles_shippings.valid?
       pay_item
       @payment_profiles_shippings.save
       redirect_to  root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private

  def payment_profiles_shippings_params
    params.require(:payment_profiles_shippings).permit(:postal_code, :origin_region_id, :city, :street_number, :building_name, :phone_number).merge(token: params[:token],price: @item.price,item_id: params[:item_id],user_id: current_user.id)
  end

  def pay_item 
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: payment_profiles_shippings_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end  

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_index 
    if current_user == @item.user || @item.sold_out?
      # ユーザーが自身が出品した商品 または　売却済み場合、トップページにリダイレクト
          redirect_to root_path
    end
  end

end


