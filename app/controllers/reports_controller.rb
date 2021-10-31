class ReportsController < ApplicationController
  def index
    @pageviews = ShortLinkReport.new(params[:slug])
  end
end
