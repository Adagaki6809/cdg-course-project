# frozen_string_literal: true

# UsersController
class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    redirect_to user_posts_path(@user)
  end

  def new
    @user = User.new
  end
end
