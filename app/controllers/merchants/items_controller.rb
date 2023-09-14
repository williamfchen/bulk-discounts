class Merchants::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @popular_items = @merchant.items.popular_items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:item_id])
  end

  def edit
    @item = Item.find(params[:item_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    item = merchant.items.create(item_params)
    redirect_to merchant_items_path(merchant)
  end

  def update
    if params[:status].present?
      item = Item.find(params[:item_id])
      # require 'pry';binding.pry
      item.update(status: params[:status].to_i)
      redirect_to merchant_items_path(params[:merchant_id])
    else
      item = Item.find(params[:item_id])
      item.update(item_params)
      redirect_to merchant_item_path(params[:merchant_id], params[:item_id])
      flash[:success] = "Item successfully updated!"
    end 
  end

  private
  
  def item_params
    params.permit(:name, :description, :unit_price, :status)
  end
end
