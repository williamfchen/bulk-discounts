class MerchantsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:merchant_id])
    @random_photo = UnsplashService.new.random_photo

  end
end
