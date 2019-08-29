class Property < ApplicationRecord
  belongs_to :user
  has_many :photos
  has_many :reservations

  validates :home_type, presence: true
  validates :guest_count, presence: true
  validates :bedroom_count, presence: true
  validates :bathroom_count, presence: true
  validates :room_type, presence: true

  def unavailable_dates
    reservations.pluck(:start_date, :end_date).map do |range|
      (range[0]..range[1]).to_a
    end
  end
end
