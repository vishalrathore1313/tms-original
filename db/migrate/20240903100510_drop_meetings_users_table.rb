class DropMeetingsUsersTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :meetings_users
  end
end
