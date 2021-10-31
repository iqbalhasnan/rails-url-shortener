class CreateShortLinkForm
  include ActiveModel::Model

  attr_accessor :url, :short_link

  validates :url, url: true

  def save
    return false unless valid?

    create_short_link
    TitleUpdaterJob.perform_later(short_link_slug: short_link.slug)
    true
  end

  private

  def link
    @link ||= Link.find_or_create_by(url: url)
  end

  def create_short_link
    @short_link ||= link.short_links.create(slug: SecureRandom.alphanumeric(14))
  end
end