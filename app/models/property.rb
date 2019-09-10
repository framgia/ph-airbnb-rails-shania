class Property < ApplicationRecord
  belongs_to :user
  has_many :photos
  has_many :reservations
  has_many :reviews, through: :reservations

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

  def guest_reviews
    guest_reviews = []
    reviews.each do |r|
      if r.user != user
        guest_reviews.push(r)
      end
    end
    return guest_reviews
  end

  def guest_review_average
    reviewCount = 0
    totalRating = 0
    reviews.each do |r|
      if r.user != user && r.rating != nil
        totalRating = totalRating + r.rating
        reviewCount = reviewCount + 1
      end
    end
    if reviewCount > 0
      return (totalRating / reviewCount)
    else
      return 0
    end
  end
end
