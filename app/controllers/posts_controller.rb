class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def new
    @current_user = current_user
    @post = Post.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit('title', 'text')
  end
end
