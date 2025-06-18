class ReviewsController < ApplicationController
  
  def create
    @review = Review.new(review_params)

    if @review.save
      redirect_back fallback_location: customer_orders_path, notice: "Review submitted!"
    else
      Rails.logger.error "Review not saved: #{@review.errors.full_messages}"
      redirect_back fallback_location: customer_orders_path, alert: "Failed: #{@review.errors.full_messages.join(', ')}"
    end
  end

  def index
    if params[:menu_item_id]
      @menu_item = MenuItem.find(params[:menu_item_id])
      @reviews = @menu_item.reviews.includes(:user)
    end
  end



  private

  def review_params
    params.require(:review).permit(:content, :rating, :user_id, :reviewable_id, :reviewable_type)
  end

end
