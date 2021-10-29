class ShortLinksController < ApplicationController
  def show
    @short_link = ShortLink.find_by(slug: params[:id])

    if @short_link.present?
      redirect_to @short_link.link.url
    end
  end
end
