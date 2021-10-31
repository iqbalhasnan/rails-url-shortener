FactoryBot.define do
  factory :short_link do
    # link
    # pageview
    association :link

    slug { SecureRandom.alphanumeric(14) }
  end
end
