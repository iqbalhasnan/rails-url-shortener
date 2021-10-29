# frozen_string_literal: true

class PageviewUpdaterJob < ApplicationJob
  queue_as :default

  def perform(slug:, remote_ip:)
    PageviewUpdater.for(slug, remote_ip)
  end
end
