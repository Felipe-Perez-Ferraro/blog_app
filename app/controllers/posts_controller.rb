class PostsController < ApplicationController
  def index
    @user = current_user
    @posts = @user.posts.paginate(page: params[:page], per_page: 4).includes(:comments, :likes)
  end

  def show
    @user = current_user
    @post = Post.find(params[:id])
  end

  def new
    @current_user = current_user
    @post = Post.new
  end

  def create
    @user = current_user
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
