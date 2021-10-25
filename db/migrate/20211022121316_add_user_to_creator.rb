class AddUserToCreator < ActiveRecord::Migration[6.1]
  def self.up
    add_belongs_to :users, :creator
  end

  def self.down
    remove_belongs_to :users, :creator
  end
end
