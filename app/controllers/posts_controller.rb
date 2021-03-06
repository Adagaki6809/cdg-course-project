# frozen_string_literal: true

# PostsController
class PostsController < ApplicationController
  def index
    @posts = Post.includes(:user).where(user_id: params[:user_id])
  end

  def show
    @post = Post.includes(:user).includes(:comments).find(params[:id])
  end

  def create
    @post = current_user.posts.create(post_params)
    redirect_to user_path(current_user)
  end

  private

  def post_params
    params.require(:post).permit(:image)
  end
end
