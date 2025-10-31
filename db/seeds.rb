# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

10.times do
    user = User.create!(name: Faker::Name.name, user_type: 'person')
    Account.create!(user:, balance: rand(1000..5000))
end

5.times do
    company = User.create!(name: Faker::Company.name, user_type: 'company')
    Account.create!(user: company, balance: rand(10_000..50_000))
end
