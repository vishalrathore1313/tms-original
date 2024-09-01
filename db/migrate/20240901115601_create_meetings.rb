class CreateMeetings < ActiveRecord::Migration[7.1]
  def change
    create_table :meetings do |t|
      t.string :topic
      t.datetime :time
      t.string :status

      t.timestamps
    end
  end
end
