class PropertiesController < ApplicationController
  before_action :check_property_params, only: [:edit, :update, :listing, :show,
    :pricing, :description, :photos, :amenities, :location]
  before_action :authenticate_user!

  def index
    @properties = current_user.properties
  end

  def new
    @property = current_user.properties.build
  end

  def create
    @property = current_user.properties.build(property_params)
     if @property.save 
      redirect_to listing_property_url(@property)
      flash[:success] = "Successfully created!"
    else
      flash[:error] = "Missing input. Please review answers."
      render 'new'        
    end
  end

  def edit
  end

  def update
    if is_complete
      @property.update_attribute(:complete, true)
      redirect_to properties_url
    else
      @property.update(property_params)
      flash[:success] = "Saved!"
      redirect_to request.referrer
    end
  end

  def show
    # @inbetween = @property.reservations.where("? < start_date AND end_date < ?", params[:start_date], params[:end_date])

    @reservation = @property.reservations.new
    @reservations = Reservation.all
  end

  def listing
  end

  def pricing
  end

  def description
  end

  def photos
    @photos = @property.photos
  end

  def amenities
  end

  def location
  end

  private
    def property_params
      params.require(:property).permit(:home_type, :guest_count, :bedroom_count, :bathroom_count, :room_type,
        :price, :title, :description, :photos, :location, :has_tv, :has_kitchen, :has_heater, :has_aircon, :has_wifi)
    end

    def check_property_params
      @property = Property.find(params[:id])
    end

    def is_complete
      complete = @property.home_type? && @property.price? && @property.title? && @property.photos.any? && @property.location? && (@property.complete? !=  "true")
    end
end
