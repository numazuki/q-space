class AnswersController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    question = Question.find(params[:question_id])
    @answer = question.answers.build(answer_params)
    @answer.user_id = current_user.id
    if @answer.save
      flash[:success]="まる"
      redirect_back(fallback_location: question_url(question.id))
    else
      flash[:danger]="batu"
      redirect_to root_url
    end
  end

  private
  def answer_params 
    params.require(:answer).permit(:content)
  end
  
end
