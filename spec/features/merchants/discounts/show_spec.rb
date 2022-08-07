require 'rails_helper'

RSpec.describe ' Merchant discounts Show Page' do

it 'shows discounts including their percentage discount and quantity thresholds' do
    Faker::UniqueGenerator.clear
    merchant_1 = Merchant.create!(name: Faker::Name.unique.name)

    discount_1 = Discount.create!(percentage: 15, quantity: 10, merchant_id: merchant_1.id)
    discount_2 = Discount.create!(percentage: 25, quantity: 20, merchant_id: merchant_1.id)

    visit merchant_discount_path(merchant_1, discount_1)

      expect(page).to have_content("Discount ##{discount_1.id}")

      expect(page).to have_content("discount percentage: %15")

      expect(page).to have_content("quantity threshold: 10")
  end

  it 'can edit the discount' do
    Faker::UniqueGenerator.clear
    merchant_1 = Merchant.create!(name: Faker::Name.unique.name)

    discount_1 = Discount.create!(percentage: 15, quantity: 10, merchant_id: merchant_1.id)
    discount_2 = Discount.create!(percentage: 25, quantity: 20, merchant_id: merchant_1.id)

    visit merchant_discount_path(merchant_1, discount_1)

    click_link "Update Discount"

    expect(current_path).to eq(edit_merchant_discount_path(merchant_1, discount_1))
    end
end
