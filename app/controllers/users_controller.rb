class UsersController < ApplicationController


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.password = @user.password_digest
    @user.update(user_params)
    redirect_to user_path,notice:"アイコンを変更しました！"
  end

private
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation,:image, :image_cache)
  end

end
