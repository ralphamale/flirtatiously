class ChangeUserFiltersBackRetry < ActiveRecord::Migration
  def change


    change_column_default :user_filters, :beg_age, nil
    change_column_default :user_filters, :end_age, nil
    change_column_default :user_filters, :sex, nil
    change_column_default :user_filters, :sexual_orientation, nil
    change_column_default :user_filters, :distance, nil
  end
end
