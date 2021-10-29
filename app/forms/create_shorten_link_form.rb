class CreateShortenLinkForm
  include ActiveModel::Model

  attr_accessor :url

  validates :url, presence: true

  def save(params = {})
    return false unless valid?

    short_link = link.short_links.create(slug: SecureRandom.alphanumeric(15))

    ShortLinkPresenter.new(short_link)
  end

  private

  def link
    @link ||= Link.find_or_create_by(url: url)
  end
end