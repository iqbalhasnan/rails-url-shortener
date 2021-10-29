class ShortLinkPresenter
  delegate :slug, to: :short_link

  def initialize(short_link)
    @short_link = short_link
  end

  def title
    short_link.link.title
  end
  def url
    short_link.link.url
  end

  private

  attr_reader :short_link
end