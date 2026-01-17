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
puts 'Cleaning database...'
Fulfillment.destroy_all
FulfillmentService.destroy_all
OrderLine.destroy_all
Order.destroy_all
Customer.destroy_all
Account.destroy_all

puts 'Creating data...'

STATUSES = %w[pending invoiced validated cancelled].freeze

# generated with AI
DRINK_NAMES = [
  "Château Margaux", "Domaine de la Romanée-Conti", "Whisky Nikka From The Barrel",
  "Rhum Diplomatico Reserva", "Gin Hendrick's", "Champagne Ruinart Blanc de Blancs",
  "Meursault Vieilles Vignes", "Cognac Hennessy VSOP", "Vodka Grey Goose",
  "Saint-Émilion Grand Cru", "Châteauneuf-du-Pape", "Sancerre Les Monts Damnés"
].freeze

puts "Creating 10 accounts..."
accounts = 10.times.map do
  Account.create!(
    firstname: Faker::Name.first_name,
    lastname: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    password: "password123",
    address: Faker::Address.full_address
  )
end

puts "Creating 10 customers..."
customers = 10.times.map do
  Customer.create!(
    firstname: Faker::Name.first_name,
    lastname: Faker::Name.last_name,
    date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 80),
    email: Faker::Internet.unique.email,
    phone: Faker::PhoneNumber.cell_phone_in_e164,
    address: Faker::Address.full_address,
    state: 'France',
    account_id: accounts.sample.id
  )
end

puts "Creating 3 fulfillment_services..."
fulfillment_services = ["Chronopost", "DHL", "Mondial Relay"].map do |name|
  FulfillmentService.create!(name: name)
end

puts "Creating 10 fulfillments..."
fulfillments = 10.times.map do |i|
  Fulfillment.create!(
    fulfillment_service_id: fulfillment_services.sample.id,
    status: ['pending', 'shipped'].sample,
    shipping_date: Time.current + 3.days,
    tracking_number: "TRACK-#{1000 + i}"
  )
end

puts "Creating 100 orders with order_lines..."

100.times do |i|
  status = STATUSES.sample
  ordered_at = Faker::Time.backward(days: 60)

  # 1. 2. 3. Generated with AI
  # 1. Creating orders
  customer = Customer.find(customers.sample.id)
  account = Account.find(accounts.sample.id)
  fulfillment = fulfillments.push(nil).sample
  order = Order.create!(
    account_id: account.id,
    customer_id: customer.id,
    reference: "ORD-20xx-#{i + 1}",
    status: status,
    customer_firstname: customer.firstname,
    customer_lastname: customer.lastname,
    customer_address: customer.address || Faker::Address.full_address,
    account_firstname: account.firstname,
    account_lastname: account.lastname,
    account_address: account.address || Faker::Address.full_address,
    ordered_at: ordered_at,
    cancelled_at: status == 'cancelled' ? ordered_at + 1.day : nil,
    vat_price: 0,
    pretax_total_price: 0, # Sera mis à jour après
    total_price: 0,
    fulfillment_id: fulfillment&.id
  )

  # 2. Creating order_lines
  order_total_pretax = 0

  rand(1..5).times do
    quantity = rand(1..12)
    pretax_unit_price = Faker::Number.between(from: 15.0, to: 150.0).round(2)
    vat_rate = 0.2

    OrderLine.create!(
      order: order,
      name: DRINK_NAMES.sample,
      quantity: quantity,
      pretax_unit_price: pretax_unit_price,
      unit_price: (pretax_unit_price * (1 + vat_rate)).round(2),
      vat_rate: vat_rate,
      vat_price: (pretax_unit_price * quantity * vat_rate).round(2)
    )

    order_total_pretax += (pretax_unit_price * quantity)
  end

  # 3. Calcul total_price
  order_vat = (order_total_pretax * 0.2).round(2)
  order.update!(
    pretax_total_price: order_total_pretax.round(2),
    vat_price: order_vat,
    total_price: (order_total_pretax + order_vat).round(2)
  )
end

puts 'The end'