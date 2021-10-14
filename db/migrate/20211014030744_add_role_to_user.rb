class AddRoleToUser < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :role,
                  null: false, foreign_key: true,
                  default_insert_value: "user"
  end
end
