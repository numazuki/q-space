class ToppagesController < ApplicationController

  def index
    if logged_in?
      @questions = Question.order(id: :desc).page(params[:page]).per(5)
      
    end
  end
end
