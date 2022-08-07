class MerchantDiscountsController < ApplicationController
  def index
      @merchant = Merchant.find(params[:merchant_id])
  end

  def show
      @discount = Discount.find(params[:id])
      @merchant = Merchant.find(params[:merchant_id])
  end

  def edit
      @discount = Discount.find(params[:id])
      @merchant = Merchant.find(params[:merchant_id])
  end

  def update
      discount = Discount.find(params[:id])
      # binding.pry
      discount.update(discount_params )
      if  params[:percentage].blank? || params[:quantity].blank?
        flash[:alert] = "Discount not updated: Please fill out all fields."
        redirect_to edit_merchant_discount_path(Merchant.find(params[:merchant_id]), discount)
      else
        redirect_to merchant_discount_path(Merchant.find(params[:merchant_id]), discount), notice: "Discount information was successfully updated!"
      end
  end

  def new
      @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    merchant.discounts.new(discount_params)
    if merchant.save
        redirect_to merchant_discounts_path(merchant)
    else
        flash[:alert] = "Discount not created: Please fill out all fields."
        render :new
    end
  end

  def destroy
    Discount.find(params[:id]).destroy
    redirect_to merchant_discounts_path(params[:merchant_id])
  end

  private
  def discount_params
      params.permit(:percentage, :quantity)
  end
end
