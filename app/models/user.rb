class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         
  has_many :items, dependent: :destroy   
  has_many :orders, dependent: :destroy  


  validates :nickname, presence: true

  validates :last_name, :first_name, presence: true,
          format: { with: /\A[ぁ-んァ-ン一-龥々ー]+\z/, message: "全角文字を使用してください" }

  validates :last_name_kana, :first_name_kana, presence: true,
            format: { with: /\A[ァ-ヶー－]+\z/, message: "全角カタカナを使用してください" }

  validates :birthday, presence: true

  validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/,
                                 message: "英字と数字の両方を含めて設定してください" }
end
