class UsersController < ApplicationController
  before_action :require_user_logged_in,only:[:index,:show,:edit,:update,]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(5)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success]='ユーザーを登録しました'
      redirect_to @user
    else
      flash[:danger] = "ユーザー登録できませんでした"
      render :new
    end
  end

  def edit
  end

  def update
  end
  
  private
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation,:image,:introduce)
  end
  
end