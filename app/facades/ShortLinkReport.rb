class ShortLinkReport
  attr_reader :slug

  def initialize(slug)
    @slug = slug
  end

  def last_minute
    pageview_counts_per("1 minute")
  end

  def last_hour
    pageview_counts_per("1 hour")
  end

  def last_week
    pageview_counts_per("1 week")
  end

  private

  def short_link
    @short_link ||= ShortLink.find_by(slug: slug)
  end

  def pageview_counts_per(time_dimension)
    short_link
      .pageviews
      .select("geolocation, time_bucket('#{time_dimension}', created_at) as time, count(*) as total")
      .group(:geolocation, :time).order(:geolocation, :time)
      .limit(10)
  end
end