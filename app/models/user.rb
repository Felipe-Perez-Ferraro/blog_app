class User < ApplicationRecord
  validates :name, presence: true
  validates :photo, presence: true

  has_many :posts 
  has_many :comments
  has_many :likes

  def order_user_posts
    posts.order(created_at: :desc).limit(3)
  end
end
