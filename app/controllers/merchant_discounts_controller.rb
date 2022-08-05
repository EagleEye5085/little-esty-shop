class MerchantDiscountsController < ApplicationController
    def index
        @discounts = Discount.all
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

    end

    def create
        discount = Discount.new(discount_params)
        if bulk_discount.save
            redirect_to admin_merchants_discount_path
        else
            flash[:alert] = "Discount not created: Please enter a name."
            render :new
        end
    end

    private
    def discount_params
        params.permit(:name, :status)
    end
end
