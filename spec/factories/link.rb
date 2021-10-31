FactoryBot.define do
  factory :link do
    url { Faker::Internet.url }
    title { Faker::Book.title }

    # factory :link_with_short_links do
    #   after(:create) do |link|
    #     create(:short_link, link: link)
    #   end
    # end
  end
end
