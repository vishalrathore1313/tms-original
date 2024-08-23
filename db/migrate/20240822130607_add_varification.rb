class AddVarification < ActiveRecord::Migration[7.1]
  def change
     add_column :users , :verification, :boolean, default: false
  end
end
