class AddColumnsToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :height, :string
    add_column :profiles, :body_type, :string
    add_column :profiles, :diet, :string
    add_column :profiles, :smokes, :string
    add_column :profiles, :drinks, :string
    add_column :profiles, :religion, :string
    add_column :profiles, :sign, :string
    add_column :profiles, :education, :string
    add_column :profiles, :job, :string
    add_column :profiles, :offspring, :string
    add_column :profiles, :pets, :string
    add_column :profiles, :likes, :text
  end
end
