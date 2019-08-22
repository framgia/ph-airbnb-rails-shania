require 'aws-sdk'

class PhotosController < ApplicationController

  def create
    @property = Property.find_by(id: params[:property_id])
    photos = params[:photos]

    photos.each do |photo|
      @property.photos.create(image: photo)
    end
    redirect_to photos_property_url(@property), success: 'File successfully uploaded'
  end

  def destroy
    @photo = Photo.find(params[:id])
    @property = @photo.property # Getting the property 
    @photo.destroy
    @photos = @property.photos
    
    flash[:success] = 'File deleted!'

    respond_to :js
  end
end
