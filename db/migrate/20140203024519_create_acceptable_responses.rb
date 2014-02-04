class CreateAcceptableResponses < ActiveRecord::Migration
  def change
    create_table :acceptable_responses do |t|
      t.integer :user_id
      t.integer :answer_choice_id
      t.integer :importance

      t.timestamps
    end
    
    add_index :acceptable_responses, :user_id
    add_index :acceptable_responses, :answer_choice_id
  end
end
