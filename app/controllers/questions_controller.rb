class QuestionsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user,only:[:destroy]
  def show
    @question = Question.find(params[:id])
    @answers = @question.answers.order(id: :desc).page(params[:page])
    @answer = @question.answers.build
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      flash[:success] = "Questionを投稿しました"
      redirect_to root_url
    else
      flash[:danger] = "Questionを投稿できませんでした"
      render :new
    end
  end

  def destroy
    @question.destroy
    flash[:success] = '質問を削除しました。'
    redirect_back(fallback_location: root_path)    
  end
  
  
  
  private
  def question_params 
    params.require(:question).permit(:title,:content)
  end
  
  def correct_user
    @question = current_user.questions.find_by(id: params[:id])
    unless @question
      redirect_to root_url
    end
  end
end
