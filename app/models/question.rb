class Question < ApplicationRecord
  belongs_to :user
  
  validates :title,presence: true,length:{maximum: 50}
  validates :content,presence: true,length:{maximum: 400}
  
  has_many :answers,dependent: :destroy
  has_many :answer_users,through: :answers,source: :user,dependent: :destroy
  
  def thanks?(answer)
    self.user.thank_answers.include?(answer)
  end
  
end
