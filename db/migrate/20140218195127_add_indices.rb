class AddIndices < ActiveRecord::Migration
  def change
    add_index "responses", ["user_id", "question_id"], unique: true
    add_index "acceptable_responses", ["user_id", "answer_choice_id"], unique: true
    add_index "acceptable_responses", ["question_id"]
    add_index "status_messages", ["user_id"]

  end
end
