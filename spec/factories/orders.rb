FactoryBot.define do
  factory :order do
    reference { "ORD-20xx-#{[1..3500].sample}" }
    customer_firstname { customer.firstname}
    customer_lastname { customer.lastname}
    customer_address { customer.address}
    account_firstname { account.firstname}
    account_lastname { account.lastname}
    account_address { account.address}
    status { 'validated' }
    ordered_at { Time.zone.now - 1.day }
    customer { FactoryBot.create(:customer) }
    account { Account.first rescue nil }
  end
end
