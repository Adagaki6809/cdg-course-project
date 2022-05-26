class LikesController < ApplicationController
  def index
    @likes = Like.all
  end

  def show
    @like = Like.find(params[:id])
  end
  
  def new
    @like = Like.new
  end

  def create
    @post = Post.find(params[:post_id])
    @likes_from_user = @post.likes.where(user_id: params[:user_id])
    if @likes_from_user.empty?
      @likes_from_user.create({ user_id: params[:user_id], post_id: params[:post_id] }) 
    else
      @likes_from_user.first.destroy
    end
    if (request.referrer.include?('posts/'))
      redirect_to user_post_path(@post.user, @post)
    else
      redirect_to user_posts_path(@post.user)
    end
  end
end