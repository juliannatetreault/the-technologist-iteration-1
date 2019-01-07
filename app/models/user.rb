class User < ApplicationRecord 
    has_many :reviews 
    has_many :comments, through: :reviews

    has_secure_password 
    validates :username, presence: true, uniqueness: true 
    validates :password, presence: true 
    validates :email, presence: true, uniqueness: true 

    def self.create_with_omniauth(auth)
      create! do |user|
        user.provider = auth["provider"]
        user.uid = auth["uid"]
        user.name = auth["info"]["name"]
        user.email = auth["email"]
      end
    end
end