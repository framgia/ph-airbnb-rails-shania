class SearchController < ApplicationController
  def search
    # filter out props non-published ones -> use "complete"
    # @rooms = @properties.WHERE complete == true && @properties.location == params[:location]
      if params[:location].present?
        session[:loc] = params[:location]
      end 

      @properties = Property.where(location: session[:loc])
      @location = session[:loc]
      @search = @properties.ransack(params[:q])
      @results = @search.result

      # respond_to do |format|
      #   format.js {
      #     render :action => 'search.js.erb'
      #   }
      # end
      # abort
      # @array = @properties.to_a
      
    # add additional filter using the end date and start date parameters -> checking the availabilities of the rooms
  end
end
