class CreateCreatorsAndBasicPosters < ActiveRecord::Migration[6.1]
  def change
    create_table :creators do |t|
      t.string :creator_name
      t.string :email_address
      t.string :sector_code
      t.string :prefix_code
      t.timestamps
    end

    create_table :basic_posters do |t|
      t.belongs_to :creator, foreign_key: true
      t.string :poster_id
      t.string :title
      t.string :description
      t.string :security_question
      t.string :security_answer
      t.string :passcode
      t.timestamps
    end
  end
end
