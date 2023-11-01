class User < ApplicationRecord
  validates :user_name, presence: true
  validates :photo, presence: true

  def get_posts
    posts.order(created_at: :desc).limit(3)
  end
end
