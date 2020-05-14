class UsersController < ApplicationController
  before_action :login_check, only: [:show, :edit, :update, :favorites]
  before_action :set_user, only: [:show, :edit, :update, :favorites]


  def show
    @pictures = @user.pictures
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id), notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def favorites
    @favorite_pictures = @user.favorite_pictures
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :image, :profile)
  end
end
