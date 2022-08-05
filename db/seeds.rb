# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Faker::UniqueGenerator.clear
merchant_1 = Merchant.create!(name: Faker::Name.unique.name)


discount_1 = Discount.create!(precentage: 15, quantity: 10, merchant_id: merchant_1.id)
discount_2 = Discount.create!(precentage: 25, quantity: 20, merchant_id: merchant_1.id)
