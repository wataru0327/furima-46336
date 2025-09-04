class OrdersController < ApplicationController
  before_action :authenticate_user!  
  before_action :set_item
  before_action :move_to_index

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item   
      @order_address.save
      redirect_to root_path, notice: "購入が完了しました"
    else

      flash.now[:alert] = "入力内容に不備があります。赤字のエラーメッセージを確認してください。"
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_address).permit(
      :postal_code, :prefecture_id, :city, :address, :building, :phone_number
    ).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def move_to_index
    if current_user.id == @item.user_id || @item.order.present?
      redirect_to root_path
    end
  end

  def pay_item
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :secret_key)  
    Payjp::Charge.create(
      amount: @item.price,            
      card: order_params[:token],     
      currency: 'jpy'                 
    )
  end
end


