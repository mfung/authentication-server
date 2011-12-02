class AddRemoteRolesPathToClient < ActiveRecord::Migration
  def change
    add_column :clients, :remote_roles_path, :string
  end
end
