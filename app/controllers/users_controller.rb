class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images
  end

  def favorites
    @user = User.find(params[:id])
    @post_images = @user.favorite_posts
  end

  def followings
    @user = User.find(params[:id])
    @following_users = @user.following_users
  end

  def followers
    @user = User.find(params[:id])
    @follower_users = @user.follower_users
  end

  def edit
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :user_name) # user_name を追加
  end
end
