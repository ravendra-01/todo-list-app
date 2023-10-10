# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

unless AccountBlock::Account.find_by_email('abc@gmail.com')
  AccountBlock::Account.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, phone_number: Faker::PhoneNumber.cell_phone, password: '123')
end

if TaskBlock::Task.any?
  account_id = AccountBlock::Account.find_by_email('abc@gmail.com').id
  10.times do |x|
    TaskBlock::Task.create(title: Faker::Lorem.words(number: rand(2..10)).first, description: Faker::Lorem.sentence(word_count: rand(2..10)).chomp('.'), status: "pending", account_id: account_id)
  end
end