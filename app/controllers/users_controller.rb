class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts
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
  
  #　Userデータの更新
  def update
    if @user.update(user_params)
      redirect_to @user, notice: '更新しました。'
    else
      render 'edit'
    end
  end
  
  def edit
  end
  
  #フォローしているユーザー
  def followings
    @user = User.find(params[:id])
    @followings = @user.following_users
  end
  
  #フォローされているユーザー
  def followers
    @user = User.find(params[:id])
    @followers = @user.follower_users
  end
  
  def likes
    @user = User.find(params[:id])
    @likes = @user.user_users
  end
  
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :body, :password, :password_confirmation)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
end
