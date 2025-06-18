class MenuItemsController < ApplicationController
  before_action :require_customer, only: [:search]

  def index
    @menu_items = current_user.menu_items
  end

  def new
    @menu_item = MenuItem.new
  end

  def create
    @menu_item = current_user.menu_items.build(menu_item_params)
    if @menu_item.save
      redirect_to menu_items_path, status: :see_other
    else
      render :new
    end
  end

  def show
    if current_user.is_a?(Restaurant)
      @menu_item = current_user.menu_items.find(params[:id])
    else
      @menu_item = MenuItem.find(params[:id])
    end
  end


  def destroy
    @menu_item = current_user.menu_items.find(params[:id])
    @menu_item.destroy
    redirect_to menu_items_path, notice: "Dish deleted successfully!"
  end
  def edit
    @menu_item = MenuItem.find(params[:id])
  end


  def update
    @menu_item = MenuItem.find(params[:id])
    if @menu_item.update(menu_item_params)
      redirect_to menu_items_path, notice: "Menu updated!"
    else
      render :edit
    end
  end
  def search
    if params[:query].present?
      @menu_items = MenuItem.where("name ILIKE ?", "%#{params[:query]}%").where(available: true)
    else
      @menu_items = []
    end
  end
  def customer_index
    if params[:query].present?
      @menu_items = MenuItem.where("name ILIKE ?", "%#{params[:query]}%").where(available: true)
    else
      @menu_items = MenuItem.where(available: true)
    end
  end
  def reviews
    @menu_item = MenuItem.find(params[:menu_item_id])
    @reviews = @menu_item.reviews.includes(:user)
  end



  private

  def menu_item_params
    params.require(:menu_item).permit(:name, :price, :available, :description)
  end

  def require_restaurant
    redirect_to root_path unless current_user.is_a?(Restaurant)
  end
  

  def require_customer
    redirect_to login_path unless current_user&.customer?
  end
  

end

