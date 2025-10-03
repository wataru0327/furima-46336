require 'rails_helper'

RSpec.describe ShippingAddress, type: :model do
  before do
    @shipping_address = FactoryBot.build(:shipping_address)
  end

  describe '配送先住所の保存' do
    context '保存できる場合' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@shipping_address).to be_valid
      end

      it '建物名が空でも保存できる' do
        @shipping_address.building = ""
        expect(@shipping_address).to be_valid
      end
    end

    context '保存できない場合' do
      it 'order_idがなければ保存できない' do
        @shipping_address.order = nil
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Order を入力してください")
      end

      it '郵便番号が空では保存できない' do
        @shipping_address.postal_code = ""
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Postal code を入力してください")
      end

      it '郵便番号にハイフンがなければ保存できない' do
        @shipping_address.postal_code = "1234567"
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Postal code は「3桁-4桁」で入力してください")
      end

      it '都道府県が「1」では保存できない' do
        @shipping_address.prefecture_id = 1
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Prefecture を選んでください")
      end

      it '市区町村が空では保存できない' do
        @shipping_address.city = ""
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("City を入力してください")
      end

      it '番地が空では保存できない' do
        @shipping_address.address = ""
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Address を入力してください")
      end

      it '電話番号が空では保存できない' do
        @shipping_address.phone_number = ""
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Phone number を入力してください")
      end

      it '電話番号が9桁以下では保存できない' do
        @shipping_address.phone_number = "090123456"
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Phone number は10桁以上11桁以内の半角数字で入力してください")
      end

      it '電話番号が12桁以上では保存できない' do
        @shipping_address.phone_number = "090123456789"
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Phone number は10桁以上11桁以内の半角数字で入力してください")
      end

      it '電話番号に数字以外が含まれている場合は保存できない' do
        @shipping_address.phone_number = "090-1234-5678"
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Phone number は数字で入力してください")
      end
    end
  end
end

