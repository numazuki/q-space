class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  
  validates :content,presence: true,length:{maximum: 255}
  
  has_many :thanks
  has_many :thank_users,through: :thanks,source: :user
  
end
