class AddStatusToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :status, :boolean
  end
end
