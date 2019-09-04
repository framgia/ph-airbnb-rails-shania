class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :property
  has_many :reviews

  default_scope -> { order(start_date: :asc) }

  validate :overlapping

  private
    def overlapping
      if Reservation.where('? <  end_date and ? > start_date', self.start_date, self.end_date).any?
        errors.add(:end_date, 'Failed to book')
      end
    end
end
