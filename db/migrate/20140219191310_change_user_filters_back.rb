class ChangeUserFiltersBack < ActiveRecord::Migration
  def change
    change_column :user_filters, :beg_age, :integer
    change_column :user_filters, :end_age, :integer
    change_column :user_filters, :sex, :string
    change_column :user_filters, :sexual_orientation, :string
    change_column :user_filters, :distance, :integer
  end

end
