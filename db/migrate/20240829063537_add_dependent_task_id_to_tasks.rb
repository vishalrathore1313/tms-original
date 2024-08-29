class AddDependentTaskIdToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :dependent_task_id, :integer
  end
end
