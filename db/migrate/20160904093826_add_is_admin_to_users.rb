class AddIsAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_admin, :bool, null: false, default: false
  end
end
