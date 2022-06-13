# frozen_string_literal: true

# CommentsController
class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    cp = comment_params
    cp[:user_id] = current_user.id
    @comment = @post.comments.create(cp)
    redirect_to user_post_path(@post.user, @post)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
