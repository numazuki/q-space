class ThanksController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    answer=Answer.find(params[:answer_id])
    question=Question.find_by(id: answer.question_id)
    unless answer.user_id==current_user.id
      current_user.thank(answer,question)
      flash[:success]='Thanks!!'
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "自分の回答にはThanksできません"
      redirect_back(fallback_location: root_path)
    end 
  end

  def destroy
    answer=Answer.find(params[:answer_id])
    question=Question.find_by(id: answer.question_id)
    unless answer.user_id==current_user.id
      current_user.unthank(answer,question)
      flash[:danger]="Not Thanks"
      redirect_back(fallback_location: root_path)
    end
  end
end
