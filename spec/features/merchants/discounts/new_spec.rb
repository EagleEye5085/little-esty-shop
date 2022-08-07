require 'rails_helper'

RSpec.describe ' Merchant discounts new Page' do

  it 'can creat a new discount' do
    Faker::UniqueGenerator.clear
    merchant_1 = Merchant.create!(name: Faker::Name.unique.name)

    visit new_merchant_discount_path(merchant_1)

    fill_in('Percentage Amount:', with: 30)
    fill_in('Quantity threshold:', with: 50)

    click_on 'Create Discount'

    expect(current_path).to eq(merchant_discounts_path(merchant_1))

    expect(page).to have_content("discount percentage: %30")

    expect(page).to have_content("quantity threshold: 50")
  end
end
