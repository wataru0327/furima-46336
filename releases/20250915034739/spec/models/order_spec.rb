require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order = Order.new(user_id: @user.id, item_id: @item.id)
  end

  describe '注文の保存' do
    context '保存できる場合' do
      it 'user_idとitem_idがあれば保存できる' do
        expect(@order).to be_valid
      end
    end

    context '保存できない場合' do
      it 'user_idがなければ保存できない' do
        @order.user_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("User を入力してください")
      end

      it 'item_idがなければ保存できない' do
        @order.item_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Item を入力してください")
      end
    end
  end
end

