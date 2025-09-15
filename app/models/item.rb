class Item < ApplicationRecord
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_charge
  belongs_to :prefecture
  belongs_to :days_to_ship

  has_one_attached :image
  has_one :order 

  with_options presence: { message: "を入力してください" } do
    validates :name
    validates :description
    validates :image
    validates :price
  end

  with_options numericality: { other_than: 1, message: "を選んでください" } do
    validates :category_id
    validates :condition_id
    validates :shipping_charge_id
    validates :prefecture_id
    validates :days_to_ship_id
  end

  validates :price, numericality: { only_integer: true, message: "は半角数字で入力してください" }

  validates :price, numericality: {
    greater_than_or_equal_to: 300,
    message: "は300以上の値にしてください"
  }
  validates :price, numericality: {
    less_than_or_equal_to: 9_999_999,
    message: "は9999999以下の値にしてください"
  }
end


