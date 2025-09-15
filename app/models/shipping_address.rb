class ShippingAddress < ApplicationRecord
  belongs_to :order

  validates :postal_code, presence: true, format: { with: /\A\d{3}-\d{4}\z/, message: "は「3桁-4桁」で入力してください" }
  validates :prefecture_id, numericality: { other_than: 1, message: "を選んでください" }
  validates :city, presence: true
  validates :address, presence: true
  validates :order_id, presence: true

  validates :phone_number, presence: true
  validates :phone_number, format: { with: /\A[0-9]+\z/, message: "は数字で入力してください" }
  validates :phone_number, length: { in: 10..11, message: "は10桁以上11桁以内の半角数字で入力してください" }
end

