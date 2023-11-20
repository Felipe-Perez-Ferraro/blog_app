class LikesController < ApplicationController
  def new
    @user = current_user
    @post = Post.find(params[:post_id])
    @like = Like.new
  end

  def create
    @current_user = current_user
    @post = Post.find(params[:post_id])
    @like = Like.create!(user: @current_user, post: @post)

    redirect_to user_posts_path(@current_user), notice: 'Post liked'
  end
end
