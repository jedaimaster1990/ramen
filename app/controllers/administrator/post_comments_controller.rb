class Administrator::PostCommentsController < ApplicationController
  layout "admin"
  before_action :authenticate_admin!

  def index
    @post_comments = PostComment.all.includes(:user, :post_image)
  end

  def show
  end

  def destroy
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy if @post_comment
    flash[:notice] = "削除しました"
    redirect_to administrator_post_comments_path
  end
end
