class Merchants::InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices.group(:id)
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:invoice_id])
  end

  def update
  if params[:item_status].present?
    merchant = Merchant.find(params[:merchant_id])
    invoice = Invoice.find(params[:invoice_id])
    item = Item.find(params[:item_id])
    invoice_item = InvoiceItem.find_by(invoice_id: params[:invoice_id], item_id: params[:item_id])
    invoice_item.update!(status: params[:item_status])
    invoice_item.save
  end 
    redirect_to merchant_invoice_path(params[:merchant_id], params[:invoice_id])
  end
end
