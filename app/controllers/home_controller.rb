class HomeController < ApplicationController
  def index
    @page, @short_links = pagy(ShortLink.all, items: 10)
  end
end
