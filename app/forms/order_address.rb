class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id,
                :city, :address, :building, :phone_number, :token

  with_options presence: { message: "を入力してください" } do
    validates :user_id
    validates :item_id
    validates :city
    validates :address
  end

  validates :token, presence: { message: "クレジットカード情報を入力してください" }

  # 郵便番号
  validates :postal_code, presence: { message: "を入力してください" }
  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: "は「3桁-4桁」で入力してください" }

  # 都道府県
  validates :prefecture_id, numericality: { other_than: 1, message: "を選択してください" }

  # 電話番号
  validates :phone_number, presence: { message: "を入力してください" }
  validates :phone_number, format: { with: /\A[0-9]+\z/, message: "は数字で入力してください" }
  validates :phone_number, length: { minimum: 10, maximum: 11, message: "は10桁以上11桁以内の半角数字で入力してください" }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      address: address,
      building: building,
      phone_number: phone_number,
      order_id: order.id
    )
  end

  def error_messages
    errors.full_messages.uniq
  end
end









