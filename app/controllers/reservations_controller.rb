class ReservationsController < ApplicationController

  def create
    @property = Property.find_by(id: params[:property_id])

    start_date = Date.strptime(params[:reservation]['start_date'], "%m/%d/%Y")
    end_date = Date.strptime(params[:reservation]['end_date'], "%m/%d/%Y")

    @reservation = current_user.reservations.new(start_date: start_date, end_date: end_date)
    @reservation.property = @property

    if current_user == @property.user
      redirect_to @property, error: 'Cannot book own property!'
    elsif @reservation.save
      redirect_to @property, success: 'Booked successfully'
    else
      redirect_to @property, error: 'Failed to book'
    end
  end

  def index
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
  end
  
end
