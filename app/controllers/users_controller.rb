class UsersController < ApplicationController
  before_action :require_user_logged_in,only:[:index,:show,:edit,:update,:thank]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(5)
  end

  def show
    @user = User.find(params[:id])
    @questions = @user.questions.order(id: :desc).page(params[:page]).per(5)

    #count
    answers=@user.answers
    @thanks_count=Thank.where(answer_id: answers).count
    
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
    @user=current_user
  end

  def update
    @user=current_user
    if @user.update(user_params)
      flash[:success]='変更しました'      
      redirect_to @user
    else
      flash[:danger]="失敗しました"
      render :edit
    end
  end
  
  def thanks
    @user=User.find(params[:id])
    thanks=Thank.where(answer_id: @user.answers)
    q_id=thanks.pluck(:question_id).uniq
    @questions=Question.where(id: q_id)
  end

  
  private
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation,:introduce)
  end
  
end
