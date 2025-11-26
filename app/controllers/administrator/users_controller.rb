class Administrator::UsersController < ApplicationController
  layout "admin"
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images
  end

  def destroy
    @user = User.find_by_id(params[:id])
    @user.destroy if @user
    flash[:notice] = "削除しました"
    redirect_to administrator_root_path
  end
end
