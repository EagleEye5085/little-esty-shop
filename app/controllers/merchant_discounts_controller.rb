class MerchantDiscountsController < ApplicationController
  def index
      @merchant = Merchant.find(params[:merchant_id])
  end

  def show
      @discount = Discount.find(params[:id])
  end

  def edit
      @discount = Discount.find(params[:id])
  end

  def update
      discount = Discount.find(params[:id])
      discount.update(discount_params )
      if params[:precentage]
          redirect_to admin_merchants_discounts_path
      elsif params[:name].blank?
          redirect_to edit_admin_merchants_discount_path(params[:id]), alert: "Please enter a precentage."
      else
          redirect_to admin_merchants_discount_path(discount), notice: "Discount information was successfully updated!"
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
      params.permit(:precentage, :quantity)
  end
end
