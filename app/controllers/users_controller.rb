class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def confirm
    # @user = User.new(user_params)
    @user = current_user.blogs.build(user_params)
    render :show if @user.invalid?
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path, notice: "プロフィール画像編集完了！"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,:image, :image_cache)
  end

end
