class TitleUpdater
  def initialize(slug)
    @slug = slug
  end

  def self.for(slug)
    new(slug).update_title
  end

  private

  def update_title
    unless title_empty?

    short_link.link.update(title: url_title)
  end

  def short_link
    @short_link ||= ShortLink.find_by(slug: slug)
  end

  def url_title
    @mechanize ||= Mechanize.new.get(short_link.link.url).title
  end

  def title_empty?
    short_link.link.title.blank?
  end

  attr_reader :slug
end