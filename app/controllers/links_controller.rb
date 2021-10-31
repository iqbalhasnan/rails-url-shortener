class LinksController < ApplicationController
  def create
    form = CreateShortLinkForm.new(link_params)

    respond_to do |format|
      if form.save
        format.js { render action: :create, locals: { short_link: form.short_link } }
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
