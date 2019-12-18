class AddQuestionIdToThanks < ActiveRecord::Migration[5.2]
  def change
    add_column :thanks, :question_id, :integer
  end
end
