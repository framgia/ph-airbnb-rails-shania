class PropertiesController < ApplicationController
  before_action :check_property_params, only: [:edit, :update, :listing, :pricing, :description, :photos, :amenities, :location]
  before_action :logged_in_user

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
    properties_param
  end

  def update
    @property = Property.find(params[:id])
    if @property.save
      @property.update(property_params)
      flash[:success] = "Successfully updated!"
      redirect_to request.referrer
    end
  end

  def listing
  end

  def pricing
  end

  def description
  end

  def photos
  end

  def amenities
  end

  def location
  end

  private
    def property_params
      params.require(:property).permit(:home_type, :guest_count, :bedroom_count, :bathroom_count, :room_type,
        :price, :title, :description, :photos, :location, :has_tv, :has_kitchen, :has_heater, :has_aricon ,:has_wifi)
    end

    def check_property_params
      @property = Property.find_by(id: params[:id])
    end
end
