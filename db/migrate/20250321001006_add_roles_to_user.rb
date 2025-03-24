class AddRolesToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :roles, :string, array: true, default: []
  end

  def up
    User.update_all(roles: ['admin'])
  end
 
end
