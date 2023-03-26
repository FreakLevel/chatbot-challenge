# frozen_string_literal: true

# Channel to keep chat with the bot
class ChatbotChannel < ApplicationCable::Channel
  # Subscribe to channel
  def subscribed
    stream_from(room)
  end

  # Unsubscribe
  def unsubscribed; end

  def test
    ActionCable.server.broadcast(
      room,
      {
        type: 'SetNewMessage', data: { key: 1, text: 'example' }
      }
    )
  end
end
