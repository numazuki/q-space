class AnswersController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    @answers = @question.answers.order(id: :desc).page(params[:page])
    @answer.user_id = current_user.id
    if @answer.save
      flash[:success]="回答を送信しました"
      redirect_to @question
    else
      flash[:danger]="回答を送信できませんでした"
      render template: "questions/show"
    end
  end

  private
  def answer_params 
    params.require(:answer).permit(:content)
  end
  
end
