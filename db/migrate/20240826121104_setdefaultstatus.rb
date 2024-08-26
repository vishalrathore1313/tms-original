class Setdefaultstatus < ActiveRecord::Migration[7.1]
  def change
    change_column_default :tasks , :status, 'Backlog'
  end
end
