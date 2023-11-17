class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.paginate(page: params[:page], per_page: 4).includes(:comments, :likes)
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
    @user = current_user
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @user = current_user

    return unless @post.destroy

    @user.decrement!(:post_counter)
    redirect_to user_posts_path(@user)
  end

  private

  def post_params
    params.require(:post).permit('title', 'text')
  end
end
