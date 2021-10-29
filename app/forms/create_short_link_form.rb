class CreateShortLinkForm
  include ActiveModel::Model

  attr_accessor :url

  validates :url, presence: true

  def save(params = {})
    return false unless valid?

    short_link = create_short_link

    TitleUpdaterJob.perform_later(short_link_slug: short_link.slug)
    ShortLinkPresenter.new(short_link)
  end

  private

  def link
    @link ||= Link.find_or_create_by(url: url)
  end

  def create_short_link
    link.short_links.create(slug: SecureRandom.alphanumeric(14))
  end
end