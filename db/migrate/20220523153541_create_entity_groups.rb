# frozen_string_literal: true

class CreateEntityGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :entity_groups do |t|
      t.integer :group_id
      t.integer :entity_id

      t.timestamps
    end
  end
end
