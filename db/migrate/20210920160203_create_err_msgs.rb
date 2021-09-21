class CreateErrMsgs < ActiveRecord::Migration[6.1]
  def change
    create_table :err_msgs do |t|
      t.string :err_code
      t.string :message
      t.string :reason
      t.string :component
      t.string :additional_note

      t.timestamps
    end
  end
end
