require "maxmind/geoip2"

class PageviewUpdater
  def initialize(slug, remote_ip)
    @slug = slug
    @remote_ip = remote_ip
  end

  def self.for(slug, remote_ip)
    new(slug, remote_ip).create_pageview
  end

  def create_pageview
    short_link.pageviews.create(
      remote_ip: remote_ip, 
      geolocation: [city_name, country_name].join(",")
    )
  end

  private

  def short_link
    @short_link ||= ShortLink.find_by(slug: slug)
  end

  def city_name
    geolite_reader&.city&.name || "City"
  end

  def country_name
    geolite_reader&.country&.name || "Country"
  end

  def geolite_reader
    @reader ||= MaxMind::GeoIP2::Reader.new(
      database: Rails.root.join("geolite", "GeoLite2-City.mmdb").to_s,
    ).city(remote_ip)
  rescue
  end
  
  attr_reader :remote_ip, :slug
end