class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    followed = User.find(params[:user_id])
    current_user.follow(followed)
    redirect_back(fallback_location: root_url)
  end

  def destroy
    followed = User.find(params[:user_id])
    current_user.unfollow(followed)
    redirect_back(fallback_location: root_url)
  end

end
