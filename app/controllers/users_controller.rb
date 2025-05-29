class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(username: params[:username])
    redirect_to root_path, alert: "User not found." and return unless @user

    @photos = @user.photos
    @follower_count = @user.received_follow_requests.where(status: "accepted").count
    @following_count = @user.sent_follow_requests.where(status: "accepted").count
    @pending_requests = @user.received_follow_requests.where(status: "pending")

    if current_user != @user
      @follow_request = FollowRequest.find_by(sender: current_user, recipient: @user)
    end
  end

  def feed
    @user = User.find_by(username: params[:username])
    # Add logic to populate @feed_photos if needed
  end

  def liked_photos
    @user = User.find_by(username: params[:username])
    # Add logic to populate @liked_photos if needed
  end

def discover
  @user = User.find_by(username: params[:username])
  following_ids = @user.sent_follow_requests.where(status: "accepted").pluck(:recipient_id)
  liked_photo_ids = Like.where(fan_id: following_ids).pluck(:photo_id).uniq
  @discover_photos = Photo.where(id: liked_photo_ids).order(created_at: :desc)
end
end
