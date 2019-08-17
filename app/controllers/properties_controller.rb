class PropertiesController < ApplicationController
  def new
    @property = current_user.properties.build
  end

  def create
    @property = current_user.properties.build(property_params)
     if @property.save 
      redirect_to listing_property_url(@property)
    else
      render 'new'        
    end
    puts @property.errors.full_messages
  end

  def edit
    @property = Property.find(params[:id])
  end

  def update
    @property = Property.find(params[:id])
    if @property.save
      @property.update(property_params)
      redirect_to request.referrer
    end
  end

  def show
  end

  def listing
    @property = Property.find(params[:id])
  end

  def pricing
    @property = Property.find(params[:id])
  end

  def description
    @property = Property.find(params[:id])
  end

  def photos
    @property = Property.find(params[:id])
  end

  def amenities
    @property = Property.find(params[:id])
  end

  def location
    @property = Property.find(params[:id])
  end

  private
      def property_params
        params.require(:property).permit(:home_type, :guest_count, :bedroom_count, :bathroom_count, :room_type,
          :price, :title, :description, :photos, :location, :has_tv, :has_kitchen, :has_heater, :has_aricon ,:has_wifi)
      end

end
