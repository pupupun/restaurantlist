class Rest < ApplicationRecord
  validates :shop_id, presence: true, length: { maximum: 255 }
  validates :name, presence: true, length: { maximum: 255 }
  validates :address, presence: true, length: { maximum: 255 }
  validates :tel, presence: true, length: { maximum: 255 }
  validates :shop_image1, presence: true, length: { maximum: 255 }
  validates :shop_image2, presence: true, length: { maximum: 255 }
  # validates :qrcode, presence: true, length: { maximum: 255 }
  
  has_many :ownerships
  has_many :users, through: :ownerships
  has_many :interests
  has_many :interest_users, through: :interests, class_name: 'User', source: :user
end
