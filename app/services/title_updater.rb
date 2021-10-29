class TitleUpdater
  def initialize(slug)
    @slug = slug
  end

  def self.for(slug)
    new(slug).update_title
  end

  def update_title
    return unless title_empty?

    short_link.link.update(title: url_title)
    broadcast_channel
  end

  private

  def short_link
    @short_link ||= ShortLink.eager_load(:link).find_by(slug: slug)
  end

  def url_title
    @mechanize ||= Mechanize.new.get(short_link.link.url).title
  rescue
    return "Error getting the Title"
  end

  def title_empty?
    short_link.link.title.blank?
  end

  def broadcast_channel
    ActionCable.server.broadcast("ShortLinkChannel", { slug: slug, title: url_title })
  end

  attr_reader :slug
end