class Book < ApplicationRecord
	belongs_to :user
  #条件を指定したいモデルに記述する。
	validates :body,length:{maximum:200} #validatesで対象となる項目を指定する。
	validates :title, presence: true #入力されたデータのpresence（存在）をチェックします。データがあればtrue
	validates :body, presence: true
end

