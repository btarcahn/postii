class CreateRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :roles do |t|
      t.string :name
      t.string :definition
      t.string :component

      t.timestamps
    end
  end
end
