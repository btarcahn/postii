class CreateElevationRequests < ActiveRecord::Migration[6.1]
  def self.up
    create_table :elevation_requests do |t|
      t.belongs_to :creator, null: false, foreign_key: true
      t.integer :status, null: false
      t.belongs_to :created_by, null: false, foreign_key: { to_table: 'users' }
      t.belongs_to :target, null: false, foreign_key: { to_table: 'users' }
      t.belongs_to :answered_by, foreign_key: { to_table: 'users' }
      t.datetime :due_date
      t.timestamps
    end
  end

  def self.down
    drop_table :elevation_requests
  end
end
