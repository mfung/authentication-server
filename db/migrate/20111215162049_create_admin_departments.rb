class CreateAdminDepartments < ActiveRecord::Migration
  def change
    create_table :admin_departments do |t|
      t.string :name

      t.timestamps
    end
  end
end
