class AddJtiRevocationStrategy < ActiveRecord::Migration[6.1]
  def self.up
    add_column :users, :jti, :string
    User.all.each { |user| user.update_column(:jti, SecureRandom.uuid) }
    change_column_null :users, :jti, false
    add_index :users, :jti, unique: true
  end

  def self.down
    remove_column :users, :jti
  end
end
