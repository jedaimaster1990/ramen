class Administrator::PostImagesController < ApplicationController
  layout "admin"
  before_action :authenticate_admin!

  def index
    @post_images = PostImage.all
  end

  def destroy
    @post_image = PostImage.find_by_id(params[:id])
    @post_image.destroy if @post_image
    flash[:notice] = "削除しました"
    redirect_to administrator_root_path
  end
end
