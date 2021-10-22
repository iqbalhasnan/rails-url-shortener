class Link < ApplicationRecord
  has_many :short_links, inverse_of: :link
end
