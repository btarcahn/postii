class CreateQuests < ActiveRecord::Migration[6.1]
  def change
    create_table :quests do |t|
      t.string :quest_type
      t.boolean :mandatory
      t.string :question
      t.string :answer
      t.belongs_to :basic_poster, null: false, foreign_key: true

      t.timestamps
    end
  end
end
