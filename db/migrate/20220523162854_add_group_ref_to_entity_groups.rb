# frozen_string_literal: true

class AddGroupRefToEntityGroups < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :entity_groups, :groups, column: :group_id, on_delete: :cascade
  end
end
