class RestaurantsController < ApplicationController
  def show
    @reviews = Review.where(reviewable: current_user)

  end
  # app/controllers/restaurants_controller.rb
  def reviews
    @restaurant_reviews = Review.where(reviewable_type: "Restaurant", reviewable_id: current_user.id)
    @menu_reviews = Review.where(reviewable_type: "MenuItem")
  end



end
