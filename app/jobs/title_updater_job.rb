# frozen_string_literal: true

class TitleUpdaterJob < ApplicationJob
  queue_as :default

  def perform(short_link_slug:)
    TitleUpdater.for(short_link_slug)
  end
end
