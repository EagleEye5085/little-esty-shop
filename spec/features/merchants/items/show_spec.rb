require 'rails_helper'

RSpec.describe 'Merchant Items Show Page' do
  before :each do
    @walmart = Merchant.create!(name: "Wal-Mart")

    @target = Merchant.create!(name: "Target")

    @costco = Merchant.create!(name: "Costco")

    @pencil = Item.create!( name: "Pencil",
                            description: "Sharpen it and write with it.",
                            unit_price: 199,
                            merchant_id: @walmart.id)

    @marker = Item.create!( name: "Marker",
                            description: "Washable!",
                            unit_price: 159,
                            merchant_id: @walmart.id)

    @eraser = Item.create!( name: "Eraser",
                            description: "Use it to fix mistakes.",
                            unit_price: 205,
                            merchant_id: @walmart.id)

    @highlighter = Item.create!( name: "Highlighter",
                            description: "Highlight things and make them yellow!",
                            unit_price: 305,
                            merchant_id: @target.id)
  end

  # User Story 2
  # Merchant Items Show Page

  # As a merchant,
  # When I click on the name of an item from the merchant items index page,
  # Then I am taken to that merchant's item's show page (/merchants/merchant_id/items/item_id)
  # And I see all of the item's attributes including:

  # Name
  # Description
  # Current Selling Price
  it 'has all of the attributes for a specific merchant item' do
    visit "/merchants/#{@walmart.id}/items/#{@pencil.id}"

    expect(page).to have_content(@pencil.name)
    expect(page).to have_content(@pencil.description)
    expect(page).to have_content(@pencil.unit_price)
    expect(page).to_not have_content(@marker.name)
    expect(page).to_not have_content(@eraser.name)
    expect(page).to_not have_content(@highlighter.name)
  end
end