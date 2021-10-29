class ShortLink < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :link, inverse_of: :short_links

  has_many :pageviews, inverse_of: :short_link
end
