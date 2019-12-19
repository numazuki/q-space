class AnswersController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    question = Question.find(params[:question_id])
    @answer = question.answers.build(answer_params)
    @answer.user_id = current_user.id
    if @answer.save
      flash[:success]="回答を送信しました"
      redirect_back(fallback_location: question_url(question.id))
    else
      flash[:danger]="回答を送信できませんでした"
      redirect_to root_url
    end
  end

  private
  def answer_params 
    params.require(:answer).permit(:content)
  end
  
end
