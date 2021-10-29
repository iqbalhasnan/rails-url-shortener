class ShortLinksController < ApplicationController
  def show
    @short_link = ShortLink.find_by(slug: params[:id])

    if @short_link.present?
      PageviewUpdaterJob.perform_later(
        slug: params[:id],
        remote_ip: request.remote_ip
      )

      redirect_to @short_link.link.url
    end
  end
end
