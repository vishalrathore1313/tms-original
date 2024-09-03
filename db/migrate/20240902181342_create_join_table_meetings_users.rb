class CreateJoinTableMeetingsUsers < ActiveRecord::Migration[7.1]
  def change
    create_join_table :meetings, :users do |t|
      t.index :meeting_id
      t.index :user_id
    end
  end
end
