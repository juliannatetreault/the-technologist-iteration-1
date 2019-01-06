class Comment < ApplicationRecord 
    belongs_to :user
    belongs_to :review

    validates :content, presence: true
    validates :content, length: { maximum: 400 }

    self.most_recent
      Comment.all.order(created_at: :desc)
    end
end