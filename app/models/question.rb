class Question < ApplicationRecord
  belongs_to :user
  
  validates :title,presence: true,length:{maximum: 50}
  validates :content,presence: true,length:{maximum: 255}
  
  has_many :answers,dependent: :destroy
  has_many :answer_users,through: :answers,source: :user,dependent: :destroy
  

  
end