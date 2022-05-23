class CreateEntityGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :entity_groups do |t|

      t.timestamps
    end
  end
end
