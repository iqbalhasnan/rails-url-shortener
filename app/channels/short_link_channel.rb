# frozen_string_literal: true

class ShortLinkChannel < ApplicationCable::Channel
  def subscribed
    stream_from "ShortLinkChannel"
  end

  def unsubscribed
    stop_all_streams
  end
end
