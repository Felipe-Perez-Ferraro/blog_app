class User < ApplicationRecord
  validates :name, presence: true
  validates :photo, presence: true
  validates :post_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  has_many :posts, foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  def order_user_posts
    posts.order(created_at: :asc).limit(3)
  end
end
