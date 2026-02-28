class PostImagesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @post_image = PostImage.new
  end

  # 投稿データの保存
  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    if @post_image.save
      flash[:notice] = "登録しました"
      redirect_to post_images_path
    else
      flash.now[:alert] = "失敗しました"
      render :new
    end
  end

  def index
    @post_image = PostImage.order(created_at: :desc)
    post_images = PostImage.all
    if params[:keyword].present?
      post_images = post_images.search(params[:keyword])
    end
    post_images = post_images.page(params[:page]).per(6)
    respond_to do |format|
      format.html do
        @post_images = post_images
      end
      format.json do
        @post_images = post_images
      end
    end
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end

  def destroy
    if @post_image.destroy
      redirect_to post_images_path, notice: "投稿を削除しました"
    else
      redirect_to post_images_path, alert: "削除に失敗しました"
    end
  end

  def edit
  end

  def update
    if @post_image.update(post_image_params)
      flash[:notice] = "編集しました"
      redirect_to post_image_path(@post_image.id)
    else
      flash.now[:alert] = "編集に失敗しました"
      render :edit
    end
  end

  # 投稿データのストロングパラメータ
  private

  def post_image_params
    params.require(:post_image).permit(:shop_name, :image, :caption, :address)
  end

  def correct_user
    @post_image = current_user.post_images.find_by(id: params[:id])
    redirect_to root_path unless @post_image
  end
end
