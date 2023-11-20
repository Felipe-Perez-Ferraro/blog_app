class Comment < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :post, class_name: 'Post'

  after_save :comments_counter

  private

  def comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
