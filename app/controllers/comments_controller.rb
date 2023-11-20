class CommentsController < ApplicationController
  def new
    @current_user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @current_user = current_user
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to user_posts_path(user_id: @user)
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @user = @comment.user
    @post_user = User.find(params[:user_id])

    return unless @comment.destroy

    redirect_to user_posts_path(@post_user)
  end

  private

  def comment_params
    params.require(:comment).permit('text')
  end
end
