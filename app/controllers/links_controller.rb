class LinksController < ApplicationController
  def create
    link = CreateShortLinkForm.new(link_params)
    short_link = link.save(link_params[:url])

    respond_to do |format|
      if short_link
        format.js { render action: :create, locals: { short_link: short_link } }
      else
        format.js { render action: :error }
      end
    end
  end

  private

  def link_params
    params
      .require(:link)
      .permit(
        :url
      )
  end
end
