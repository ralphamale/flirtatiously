class AddQuestionIdToAcceptableResponses < ActiveRecord::Migration
  def change
    add_column :acceptable_responses, :question_id, :integer
  end
end
