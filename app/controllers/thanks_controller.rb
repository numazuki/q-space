class ThanksController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    answer=Answer.find(params[:answer_id])
    question=Question.find_by(id: answer.question_id)
    current_user.thank(answer,question)
    flash[:success]='サンキュー'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    answer=Answer.find(params[:answer_id])
    question=Question.find_by(id: answer.question_id)
    current_user.unthank(answer,question)
    flash[:danger]="kaizyo"
    redirect_back(fallback_location: root_path)
  end
end
