class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_item, only: [:show, :edit, :update]
  before_action :move_to_index, only: [:edit, :update]

  def index
    @items = Item.includes(:user).order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: 
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
    
  end

  def update
    update_params = item_params
    update_params = update_params.except(:image) if update_params[:image].blank?

    if @item.update(update_params)
      redirect_to @item, notice: 
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

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

  def move_to_index
    redirect_to root_path unless current_user.id == @item.user_id
  end
end