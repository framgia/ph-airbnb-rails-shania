class Review < ApplicationRecord
  belongs_to :reservation
  belongs_to :user
  belongs_to :property
end
