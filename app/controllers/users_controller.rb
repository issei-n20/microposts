class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    # Userクラスの新しいインスタンスを作成して、インスタンス変数に代入
    @user = User.new
  end
  
  #　Userデータの作成
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
