require 'rails_helper'

RSpec.describe ' Merchant discounts edit Page' do
  before :each do

    Faker::UniqueGenerator.clear
    @merchant_1 = Merchant.create!(name: Faker::Name.unique.name)

    @discount_1 = Discount.create!(percentage: 15, quantity: 10, merchant_id: @merchant_1.id)
    @discount_2 = Discount.create!(percentage: 25, quantity: 20, merchant_id: @merchant_1.id)

    visit edit_merchant_discount_path(@merchant_1, @discount_1)

  end

  it 'has a form pre-filled with the existing attribute information for a discount' do

    within '#percentage-field' do
      expect(page).to have_field(:percentage, with: @discount_1.percentage)
    end

    within '#quantity-field' do
      expect(page).to have_field(:quantity, with: @discount_1.quantity)
    end
  end

  it 'can update the information for an item' do

    within '#percentage-field' do
      fill_in :percentage, with: 25
    end

    within '#quantity-field' do
      fill_in :quantity, with: 25
    end

    click_button 'Update Discount'

    expect(current_path).to eq(merchant_discount_path(@merchant_1, @discount_1))

    expect(page).to have_content("discount percentage: %25")
    expect(page).to have_content("quantity threshold: 25")

    expect(page).to_not have_content("discount percentage: %15")
    expect(page).to_not have_content("quantity threshold: 10")
  end

  it 'redirects to the edit form if not all fields are filled in' do

    fill_in :percentage, with: ""

    click_on("Update Discount")

    expect(current_path).to eq(edit_merchant_discount_path(@merchant_1, @discount_1))
    expect(page).to have_content('Discount not updated: Please fill out all fields.')
  end
end
