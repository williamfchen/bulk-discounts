class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
      if params[:name].present?
        merchant.update(merchant_params)
        redirect_to admin_merchant_path(merchant)
        flash[:success] = "Merchant was successfully updated"
      elsif params[:enabled].present?
        merchant.update(merchant_params)
        redirect_to admin_merchants_path
      else 
        redirect_to edit_admin_merchant_path(merchant)
        flash[:error] = "Please fill in the name"
      end
  end

  def merchant_params
    params.permit(:name, :enabled)
  end
end