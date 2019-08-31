class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @reservation = Reservation.find(params[:review][:reservation_id])
    @review = @reservation.reviews.build(review_params)
    if @review.save
      redirect_to reservations_url(@reservation)
    else
      flash[:danger] = 'Something is not right'
      render 'trips'
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    
    flash[:success] = 'Review Removed!'

    redirect_back(fallback_location: root_path) 
  end

  # Reservations
  def review_guest
    @property = Property.find_by(id: params[:property_id])
    @reservation = Reservation.find_by(id: params[:reservation_id])
    
    respond_to do |format|
      format.js {
        render :action => 'review.js.erb'
      }
    end
  end

    # Trips
  def review_host
    @property = Property.find_by(id: params[:property_id])
    @reservation = Reservation.find_by(id: params[:reservation_id])

    respond_to do |format|
      format.js {
        render :action => 'review.js.erb'
      }
    end
  end

  private
    def check_property_params
      @property = Property.find_by(id: params[:property_id])
    end

    def review_params
      params.require(:review).permit(:rating, :comment, :reservation_id, :property_id, :user_id)
    end
end
