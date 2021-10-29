class Pageview < ApplicationRecord
  belongs_to :short_link, inverse_of: :pageviews
end
