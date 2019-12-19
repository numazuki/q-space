class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  
  validates :content,presence: true,length:{maximum: 400}
  
  has_many :thanks,dependent: :destroy
  has_many :thank_users,through: :thanks,source: :user
  
end
