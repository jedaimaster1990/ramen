class FavoritesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    post_image = PostImage.find(params[:post_image_id])
    current_user.favorite(post_image)
    redirect_back(fallback_location: root_url)
  end

  def destroy
    post_image = PostImage.find(params[:post_image_id])
    current_user.unfavorite(post_image)
    redirect_back(fallback_location: root_url)
  end

end
