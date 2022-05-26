# frozen_string_literal: true

class AddUserRefToEntities < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :entities, :users, column: :author_id, on_delete: :cascade
  end
end
