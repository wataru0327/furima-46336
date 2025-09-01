class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]  

  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: '商品を出品しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :name, 
      :description, 
      :category_id, 
      :condition_id,
      :shipping_charge_id, 
      :prefecture_id, 
      :days_to_ship_id,
      :price, 
      :image
      ).merge(user_id: current_user.id)
  end
end