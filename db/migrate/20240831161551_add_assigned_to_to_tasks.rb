class AddAssignedToToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :assigned_to, :integer
  end
end
