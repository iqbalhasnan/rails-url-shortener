class HomeController < ApplicationController
  def index
    @short_links = ShortLink.all
  end
end
