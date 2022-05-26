class EntityGroups < ApplicationRecord
  after_create :increase_total_amount
  belongs_to :entity
  belongs_to :group

  private

  def increase_total_amount
    group.increment!(:total_amount, entity.amount)
  end
end
