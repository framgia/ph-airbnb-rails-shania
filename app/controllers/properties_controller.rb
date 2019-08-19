class PropertiesController < ApplicationController
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
    properties_param
    if @property.update(property_params)
      flash[:success] = "Successfully updated!"
    else
      flash[:error] = "Missing input. Please review answers."
    end
    redirect_to request.referrer
  end

  def show
  end

  def listing
    properties_param
  end

  def pricing
    properties_param
  end

  def description
    properties_param
  end

  def photos
    properties_param
  end

  def amenities
    properties_param
  end

  def location
    properties_param
  end

  private
    def property_params
      params.require(:property).permit(:home_type, :guest_count, :bedroom_count, :bathroom_count, :room_type,
        :price, :title, :description, :photos, :location, :has_tv, :has_kitchen, :has_heater, :has_aricon ,:has_wifi)
    end

end
