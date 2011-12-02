class AddUriToClient < ActiveRecord::Migration
  def change
    add_column :clients, :uri, :string
  end
end
