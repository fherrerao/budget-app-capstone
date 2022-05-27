class Group < ApplicationRecord
  has_one_attached :avatar
  belongs_to :user, class_name: 'User', foreign_key: 'author_id'
  has_many :entity_groups, class_name: 'EntityGroups', foreign_key: 'group_id', dependent: :delete_all

  validates :name, presence: true, length: { maximum: 50 }
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0,
                                                           less_than_or_equal_to: 999_999_999.99 },
                           format: { with: /\A\d+(?:\.\d{0,2})?\z/ }
end
