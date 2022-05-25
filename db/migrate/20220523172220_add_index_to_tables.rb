class AddIndexToTables < ActiveRecord::Migration[7.0]
  def change
    add_index :groups, :author_id
    add_index :entities, :author_id

    add_index :entity_groups, :group_id
    add_index :entity_groups, :entity_id
  end
end
