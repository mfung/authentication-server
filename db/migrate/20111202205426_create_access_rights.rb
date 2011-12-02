class CreateAccessRights < ActiveRecord::Migration
  def change
    create_table :access_rights do |t|
      t.references :user
      t.references :client
      t.string :roles

      t.timestamps
    end
    add_index :access_rights, :user_id
    add_index :access_rights, :client_id
  end
end
