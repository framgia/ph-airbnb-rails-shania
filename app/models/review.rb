class Review < ApplicationRecord
  belongs_to :reservation
  belongs_to :user
  belongs_to :property

  validates_uniqueness_of :user_id, scope: :property_id, message: "You can't review a property more than once", on: 'create'
end
