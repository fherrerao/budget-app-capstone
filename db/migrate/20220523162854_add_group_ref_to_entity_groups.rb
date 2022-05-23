class AddGroupRefToEntityGroups < ActiveRecord::Migration[7.0]
  def change
    add_reference :entity_groups, :group, null: false, foreign_key: true
  end
end
