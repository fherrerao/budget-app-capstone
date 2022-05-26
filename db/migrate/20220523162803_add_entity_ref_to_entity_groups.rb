# frozen_string_literal: true

class AddEntityRefToEntityGroups < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :entity_groups, :entities, column: :entity_id, on_delete: :cascade
  end
end
