class OrdersController < ApplicationController
  before_action :authenticate_user!  
  before_action :set_item
  before_action :move_to_index

  def index
    @order_address = OrderAddress.new
  end

  def create
    Rails.logger.info "DEBUG: params[:token] = #{params[:token]}"
    Rails.logger.info "DEBUG: order_params = #{order_params.inspect}"

    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      if pay_item
        @order_address.save
        redirect_to root_path, notice: "購入が完了しました"
      else
        flash.now[:alert] = "決済処理に失敗しました。時間をおいて再度お試しください。"
        render :index, status: :unprocessable_entity
      end
    else
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
    begin
      Payjp::Charge.create(
        amount: @item.price,           # 商品の価格
        card: order_params[:token],    # ✅ ここを card に変更
        currency: 'jpy'
      )
      true
    rescue Payjp::PayjpError => e
      Rails.logger.error "Payjp error: #{e.message}"
      false
    end
  end
end





