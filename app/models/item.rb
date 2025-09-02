class Item < ApplicationRecord
  belongs_to :user
  # has_one :order


  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_charge
  belongs_to :prefecture
  belongs_to :days_to_ship


  has_one_attached :image


  with_options presence: true do
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

 
  validates :price, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 300,
    less_than_or_equal_to: 9_999_999
  }, allow_blank: true

 
  # def sold_out?
  #   self.order.present?
  # end
end