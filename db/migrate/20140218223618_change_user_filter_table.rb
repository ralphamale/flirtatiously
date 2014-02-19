class ChangeUserFilterTable < ActiveRecord::Migration
  def change
    change_column :user_filters, :beg_age, :integer, :default => 18
    change_column :user_filters, :end_age, :integer, :default => 99
    change_column :user_filters, :sex, :string, :default => "Everyone"
    change_column :user_filters, :sexual_orientation, :string, :default => "All"
    add_column :user_filters, :distance, :integer, :default => 6969


  end
end
