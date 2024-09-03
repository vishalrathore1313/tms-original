class DropMeetingsUsersJoinTable < ActiveRecord::Migration[7.1]
  def change
    def change
      drop_table :meetings_users, if_exists: true
    end
  end
end
