FactoryBot.define do
  factory :pageview do
    association :short_link

    remote_ip { Faker::Internet.ip_v4_address }
    geolocation { [Faker::Address.city, Faker::Address.country].join(",") }
  end
end
