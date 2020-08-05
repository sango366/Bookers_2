class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  attachment :profile_image #profile_imageを持たせたモデルに書く.IDはつけない。なせ画像用のモデルを作らなくていいかのヒントになりそう
  validates :name, presence: true, length: {minimum:2, maximum:20} #ここをpresence, trueとかにすると、サーバー立ち上がらない。undefined method `to_sym' for true:TrueClassって表示される。
  validates :introduction, length:{maximum:50}
end
