class Merchants::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @popular_items = @merchant.popular_items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:item_id])
    # @random_photo = UnsplashService.new.random_photo
    @search_photo = UnsplashService.new.search_photo(@item.name)
  end

  def edit
    @item = Item.find(params[:item_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    item = merchant.items.new(item_params)
    item.save
    if item.save
      redirect_to merchant_items_path(merchant)
      flash[:success] = "Item successfully created!"
    elsif !item.save
      redirect_to new_merchant_item_path(merchant)
      flash[:error] = "Item not created: Required information missing."
    end
  end

  def update
    item = Item.find(params[:item_id])
    if params[:status].present?
      item.update(status: params[:status].to_i)
      redirect_to merchant_items_path(params[:merchant_id])
    elsif params[:name].present? && params[:description].present? && params[:unit_price].present?
      item.update(item_params)
      redirect_to merchant_item_path(params[:merchant_id], params[:item_id])
      flash[:success] = "Item successfully updated!"
    elsif !params[:name].present? || !params[:description].present? || !params[:unit_price].present? 
      redirect_to edit_merchant_item_path(params[:merchant_id], params[:item_id])
      flash[:error] = "Item not updated: Required information missing."
    end 
  end

  private
  
  def item_params
    params.permit(:name, :description, :unit_price, :status)
  end
end
