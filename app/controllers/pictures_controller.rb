class PicturesController < ApplicationController
  before_action :login_check, only: [:index, :new, :show, :edit, :update, :destroy]
  before_action :set_picture, only: [:show, :edit, :update, :destroy]

  def index
    @pictures = Picture.all
  end

  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
    @comment = Comment.new
    @comment.picture_id = params[:picture_id]
    @comments = @picture.comments
  end

  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end
  def confirm
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end

  def edit
  end

  def create
    @picture = current_user.pictures.build(picture_params)

    if params[:back]
      render :new
    elsif @picture.save
      PictureMailer.picture_mail(@picture).deliver
      redirect_to pictures_path, notice: '投稿完了しました！'
    end
  end

  def update
    if @picture.update(picture_params)
      redirect_to pictures_path, notice: '編集完了しました！'
    else
      render :edit
    end
  end

  def destroy
    @picture.destroy
    redirect_to pictures_path, notice: '削除完了しました！'
  end

  private
  def set_picture
    @picture = Picture.find(params[:id])
  end

  def picture_params
    params.require(:picture).permit(:image, :content, :image_cache)
  end
end
