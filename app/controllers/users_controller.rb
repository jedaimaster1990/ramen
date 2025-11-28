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
    #URLのparams[:id]からユーザーを所得
    @user = User.find(params[:id])
    #そのユーザーが投稿した記事一覧を所得
    @post_images = @user.post_images.order(created_at: :desc)
  end

  def edit
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :user_name) # user_name を追加
  end
end
