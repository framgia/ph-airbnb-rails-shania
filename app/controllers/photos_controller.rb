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
    Photo.find(params[:id]).destroy
    flash[:success] = 'File deleted!'
    redirect_to request.referrer
  end
end
