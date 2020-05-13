class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]


  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    if logged_in?
      @user = User.find(params[:id])
    else
      redirect_to new_session_path
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id), notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to user_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
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
