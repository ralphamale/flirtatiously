class RenameColumnInNotifications < ActiveRecord::Migration
  def change
    rename_column :notifications, :type, :status_type
  end
end
