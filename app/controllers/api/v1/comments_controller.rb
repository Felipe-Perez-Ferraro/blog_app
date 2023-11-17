class Api::V1::CommentsController < ApplicationController
  before_action :set_user
  before_action :set_post

  def index
    @comments = @post.comments
    render json: @comments
  end

  def create
    @comment = @post.comments.build(comments_params)
    @comment.user = @user

    if @comment.save
      render json: @comment, status: :created
    else
      render json: { error: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = @user.posts.find(params[:post_id])
  end

  def comments_params
    params.require(:comment).permit(:text)
  end
end
