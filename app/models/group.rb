class Group < ApplicationRecord
  has_one_attached :icon
  belongs_to :user  
  has_many :entity_groups,  class_name: "EntityGroups", foreign_key: "group_id", dependent: :delete_all
end
