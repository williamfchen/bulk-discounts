class Merchants::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:item_id])
  end

  def edit
    @item = Item.find(params[:item_id])
  end

  def update
    item = Item.find(params[:item_id])
    item.update(item_params)
    redirect_to merchant_item_path(params[:merchant_id], params[:item_id])
    flash[:success] = "Item successfully updated!"
  end

  private
  
  def item_params
    params.permit(:name, :description, :unit_price)
  end
end
