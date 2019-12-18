class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true,length:{maximum: 50}
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :questions
  has_many :answers
  has_many :answer_questions,through: :answers,source: :question
  has_many :thanks
  has_many :thank_answers,through: :thanks,source: :answer
  
  
  
  def thank(answer,question)
    thanks.find_or_create_by(answer_id: answer.id,question_id: question.id)
  end
  
  
  def unthank(answer,question)
    thank = self.thanks.find_by(answer_id: answer.id,question_id: question.id)
    thank.destroy if thank
  end
  
  def thank_answers?(answer)
    self.thank_answers.include?(answer)
  end

  
end
