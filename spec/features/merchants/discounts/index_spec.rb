require 'rails_helper'

RSpec.describe ' Merchant discounts Index Page' do

it 'shows discounts including their percentage discount and quantity thresholds' do
    Faker::UniqueGenerator.clear
    merchant_1 = Merchant.create!(name: Faker::Name.unique.name)

    discount_1 = Discount.create!(percentage: 15, quantity: 10, merchant_id: merchant_1.id)
    discount_2 = Discount.create!(percentage: 25, quantity: 20, merchant_id: merchant_1.id)

    visit merchant_discounts_path(merchant_1)

    within "#discount-#{discount_1.id}" do

      expect(page).to have_content("Discount ##{discount_1.id}")

      expect(page).to have_content("discount percentage: %15")

      expect(page).to have_content("quantity threshold: 10")
    end
  end

  it 'I see a link to create a new discount' do
    Faker::UniqueGenerator.clear
    merchant_1 = Merchant.create!(name: Faker::Name.unique.name)

    visit merchant_discounts_path(merchant_1)

    click_link "Create discount"

    expect(current_path).to eq(new_merchant_discount_path(merchant_1))
  end

  it 'can delete a discount' do
    Faker::UniqueGenerator.clear
    merchant_1 = Merchant.create!(name: Faker::Name.unique.name)

    discount_1 = Discount.create!(percentage: 15, quantity: 10, merchant_id: merchant_1.id)
    discount_2 = Discount.create!(percentage: 25, quantity: 20, merchant_id: merchant_1.id)

    visit merchant_discounts_path(merchant_1)

    within "#discount-#{discount_1.id}" do
      click_link "Delete"
    end

    expect(page).to_not have_content("Discount ##{discount_1.id}")

    expect(page).to_not have_content("discount percentage: %15")

    expect(page).to_not have_content("quantity threshold: 10")
  end

end
