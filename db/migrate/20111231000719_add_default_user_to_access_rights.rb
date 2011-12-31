class AddDefaultUserToAccessRights < ActiveRecord::Migration
  def change
    add_column :access_rights, :default_user, :boolean
  end
end
