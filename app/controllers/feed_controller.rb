# frozen_string_literal: true

# FeedController
class FeedController < ApplicationController
  def index
    @feed = Post.where(user_id: current_user.following.all).order(created_at: :desc)
  end
end
