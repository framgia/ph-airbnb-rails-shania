class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])

    @guest_reviews = []
    @host_reviews = []

    @user.properties.each do |property|
      property.reviews.each do |review|
        if review.user != @user
          @guest_reviews.push(review)
        end
      end 
    end

    @user.reservations.each do |reservation|
      reservation.reviews.each do |review|
        if review.user != @user
          @host_reviews.push(review)
        end
      end
    end
  end
end