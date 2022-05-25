class Entity < ApplicationRecord  
  belongs_to :user, class_name: "User", foreign_key: "user_id"  
  has_many :entity_groups, class_name: "EntityGroups", foreign_key: "entity_id",   dependent: :delete_all
end
