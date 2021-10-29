class HomeController < ApplicationController
  def index
    @short_links = ShortLink.all.map do |short_link|
      ShortLinkPresenter.new(short_link)
    end
  end
end
