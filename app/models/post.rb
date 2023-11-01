class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'

  after_save :post_counter

  def order_post_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def post_counter
    author.update(post_counter: author.posts.count)
  end
end
