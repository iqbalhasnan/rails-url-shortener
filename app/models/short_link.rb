class ShortLink < ApplicationRecord
  belongs_to :link

  has_many :pageviews, inverse_of: :short_link
end
