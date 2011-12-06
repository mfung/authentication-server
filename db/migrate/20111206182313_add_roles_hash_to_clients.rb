class AddRolesHashToClients < ActiveRecord::Migration
  def change
    add_column :clients, :roles_hash, :string
  end
end
