FactoryBot.define do
  factory :customer do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    date_of_birth { Faker::Date.backward(days: 7777) }
    email { Faker::Internet.unique.email }
    phone { Faker::PhoneNumber.cell_phone_in_e164 }
    address { Faker::Address.full_address }
    state { 'France' }
    account { Account.first rescue nil }
  end

  factory :andrea, class: Customer do
    firstname { 'Andréa' }
    lastname { 'Morvan' }
    date_of_birth { '1984-11-24' }
    email { 'andreamorvan@gmail.com' }
    phone { '0607080808' }
    address { '23 rue du soleil 13012 Marseille' }
    state { 'France' }
  end
end
