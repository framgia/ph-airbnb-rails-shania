class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def create
    @property = Property.find_by(id: params[:property_id])
    if current_user != @property.user
      start_date = Date.strptime(params[:reservation]['start_date'], "%m/%d/%Y")
      end_date = Date.strptime(params[:reservation]['end_date'], "%m/%d/%Y")

      @reservation = current_user.reservations.new(start_date: start_date, end_date: end_date)
      @reservation.property = @property

      if @reservation.save
        @reservation.total_price = (((@reservation.end_date - @reservation.start_date).to_i) * @property.price)
        @reservation.update_attribute(:total_price, @reservation.total_price)

        redirect_to @property, success: 'Booked successfully'
      else
        redirect_to @property, error: 'Failed to book'
      end
    else
      redirect_to @property, error: 'Cannot book own property!'
    end
  end

  def reservations
    @properties = current_user.properties
    
    @count = 0
    @properties.each do |property|
      if property.reservations.any? 
        @count = @count+1
      end
    end
  end

  def trips
    @properties = current_user.properties
    @reservation = Reservation.find_by(id: params[:id])
    @review = Review.find_by(id: params[:id])
  end
end
