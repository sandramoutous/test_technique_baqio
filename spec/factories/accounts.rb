FactoryBot.define do
  factory :account do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    address { Faker::Address.full_address }
  end
end
