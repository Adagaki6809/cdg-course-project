# frozen_string_literal: true

# LikesController
class LikesController < ApplicationController
  def index
    @likes = Like.all
  end

  def create
    @post = Post.find(params[:post_id])
    @likes_from_user = @post.likes.where(user_id: current_user.id)
    if @likes_from_user.empty?
      @likes_from_user.create(user_id: current_user.id, post_id: params[:post_id])
    else
      @likes_from_user.first.destroy
    end
    if request.referrer.include?('posts/')
      redirect_to user_post_path(@post.user, @post)
    elsif request.referrer.include?('posts')
      redirect_to user_posts_path(@post.user)
    else
      redirect_to user_feed_index_path(current_user)
    end
    #redirect_to request.referrer
  end
end
