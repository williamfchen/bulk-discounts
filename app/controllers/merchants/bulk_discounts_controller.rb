class Merchants::BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts.order(percentage_discount: :asc)
  end

  def show 
    @bulk_discount = BulkDiscount.find(params[:discount_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.new(bulk_discount_params)
  
    if @bulk_discount.save
      redirect_to merchant_bulk_discounts_path(@merchant), notice: 'Bulk discount created.'
    else
      render :new
    end
  end
  
  def destroy
    @bulk_discount = BulkDiscount.find(params[:discount_id])
    @bulk_discount.destroy

    redirect_to merchant_bulk_discounts_path(params[:merchant_id]), notice: 'Bulk discount deleted.'
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:discount_id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:discount_id])
    
    if @bulk_discount.update(bulk_discount_params)
      redirect_to merchant_bulk_discount_path(@merchant, @bulk_discount)
    else
      render :edit
    end
  end

  private
  
  def bulk_discount_params
    params.require(:bulk_discount).permit(:percentage_discount, :quantity_threshold)
  end
end
