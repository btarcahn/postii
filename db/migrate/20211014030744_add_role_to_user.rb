class AddRoleToUser < ActiveRecord::Migration[6.1]
  def up
    add_reference :users, :role,
                  null: false, foreign_key: true
    change_column_default :users, :role_id, 2
  end

  def down
    remove_reference :users, :role, index: true, foreign_key: true
  end
end
