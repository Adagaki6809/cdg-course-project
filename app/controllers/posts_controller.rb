class PostsController < ApplicationController
  def index
    @posts = Post.includes(:user).where(:user_id => params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.create(post_params)
    redirect_to user_path(@user)
  end

  private
    def post_params
      params.require(:post).permit(:image)
    end
end
