class AddQuestionIdToResponses < ActiveRecord::Migration
  def change
    add_column :responses, :question_id, :integer
  end
end
