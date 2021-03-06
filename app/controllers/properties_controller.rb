class PropertiesController < ApplicationController
  before_action :check_property_params, only: [:edit, :update, :listing, :show,
    :pricing, :description, :photos, :amenities, :location]
  before_action :authenticate_user!, except: [:show]
  autocomplete :property, :location, full: true, where: { complete: true }, unique: true

  def index
    @properties = current_user.properties
  end

  def search_index
    @search = Property.ransack(params[:q])
    @properties = @search.result
    @search.build_condition
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
    @locations = Property.near([@property.latitude, @property.longitude], 50, :order => :distance)

    @guest_reviews = []
    @guest_review_ratings = 0
    @guest_review_average = 0

    @reviews.each do |review|
      if review.user != @property.user
        @guest_reviews.push(review)
        @guest_review_ratings = @guest_review_ratings + (review.rating != nil ?  review.rating : 0)
      end # if
    end # each do

    if @guest_reviews.count != 0
      @guest_review_average = (@guest_review_ratings / @guest_reviews.count)
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
        :price, :title, :description, :photos, :location,
        :has_tv, :has_kitchen, :has_heater, :has_aircon, :has_wifi,
        :latitude, :longtitude)
    end

    def check_property_params
      @property = Property.find(params[:id])
    end

    def is_complete
      complete = @property.home_type? && @property.price? && @property.title? && @property.photos.any? && @property.location? && (@property.complete? !=  "true")
    end
end
