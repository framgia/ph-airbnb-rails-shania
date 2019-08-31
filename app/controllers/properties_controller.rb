class PropertiesController < ApplicationController
  before_action :check_property_params, only: [:edit, :update, :listing, :show,
    :pricing, :description, :photos, :amenities, :location]
  before_action :authenticate_user!, except: [:show]

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
    @reservation = @property.reservations.new
    @reviews = @property.reviews
    @guest_reviews = []

    @reviews.each do |review|
      if review.user != @property.user
        @guest_reviews.push(review)
      end
    end 
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
