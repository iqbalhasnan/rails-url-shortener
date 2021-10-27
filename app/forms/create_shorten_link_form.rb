class CreateShortenLinkForm
  include ActiveModel::Model

  attr_accessor :url

  validates :url, presence: true

  def save(params = {})
    return false unless valid?

    link.short_links.create(slug: SecureRandom.alphanumeric(15))
  end

  private

  def link
    @link ||= Link.find_or_create_by(url: url)
  end
end