class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :category
      t.string :text

      t.timestamps
    end
  end
end
