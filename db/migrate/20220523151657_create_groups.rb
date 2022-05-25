class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :icon
      t.decimal :total_amount, default: 0.0
      t.integer :author_id

      t.timestamps
    end
  end
end
