class SearchController < ApplicationController
  def search
    # filter out props non-published ones -> use "complete"
    # @rooms = @properties.WHERE complete == true && @properties.location == params[:location]
      if params[:location].present?
        session[:loc] = params[:location]
      end 

      @search = Property.where(location: session[:loc], complete: true).ransack(params[:q])
      @results = @search.result.to_a
      @location = session[:loc]
      
      begin
        @start_date = Date.strptime(params[:"start_date"], "%m/%d/%Y")
        @end_date = Date.strptime(params[:"end_date"], "%m/%d/%Y")
        
        @results.each do |property|
          unavailable_property = property.reservations.where(
            "(? <= start_date AND start_date <= ?) OR (? <= end_date AND end_date <= ?)", 
            @start_date, @end_date, @start_date, @end_date)
          if unavailable_property.any?
            @results.delete(property)
          end
        end
      rescue
      end 

      # respond_to do |format|
      #   format.js {
      #     render :action => 'search.js.erb'
      #   }
      # end
  end
end
