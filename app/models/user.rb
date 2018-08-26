class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  
  has_secure_password
  
  has_many :ownerships
  has_many :rests, through: :ownerships
  has_many :interests
  has_many :interest_rests, through: :interests, source: :rest
  
  def interest(rest)
    self.interests.find_or_create_by(rest_id: rest.id)
  end
  
  def uninterest(rest)
    interest = self.interests.find_by(rest_id: rest.id)
    interest.destroy if interest
  end
  
  def interest?(rest)
    self.interest_rests.include?(rest)
  end
end
