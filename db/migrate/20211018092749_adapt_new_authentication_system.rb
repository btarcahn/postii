class AdaptNewAuthenticationSystem < ActiveRecord::Migration[6.1]
  def up
    remove_column :users, :password_digest
    add_column :users, :role, :string
    change_column_default :users, :role, from: nil, to: 'User'
    User.find_each do |user|
      unless user.role.present?
        user.role = 'User'
      end
    end
    change_column_null :users, :role, false
  end

  def down
    remove_column :users, :role
    add_column :users, :password_digest, :string
  end
end
