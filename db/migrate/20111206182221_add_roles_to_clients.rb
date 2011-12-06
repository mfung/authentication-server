class AddRolesToClients < ActiveRecord::Migration
  def change
    add_column :clients, :roles, :string
  end
end
