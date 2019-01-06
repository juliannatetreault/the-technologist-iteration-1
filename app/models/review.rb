class Review < ApplicationRecord 
    belongs_to :user 
    has_many :comments, through: :users 

    validates :content, presence: true 
    validates :content, length: { minimum: 250 }

    self.most_recent
      Review.all.order(created_at: :desc)
    end
end