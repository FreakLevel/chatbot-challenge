# frozen_string_literal: true

# Channel to keep chat with the bot
class ChatbotChannel < ApplicationCable::Channel
  # Subscribe to channel
  def subscribed
    stream_from(room)
  end

  # Unsubscribe
  def unsubscribed; end

  def init_conversation
    path = BotPath.find_by(initial: true)
    send_messages(path)
  end

  def receive_message(payload)
    payload = payload.with_indifferent_access
    input = payload[:input]
    value = payload[:value]
    current_path = BotPath.find_by(identifier: Rails.cache.read("#{room}_last_path"))
    current_path = BotPath.find_by(initial: true) if current_path.nil?
    if current_path.options
      option = current_path.options[value]
      return bad_option if option.nil?

      next_step = BotPath.find_by(identifier: option)
    else
      Rails.cache.write("#{room}_#{input}", value)
      next_step = current_path.next_step
    end
    send_messages(next_step)
  end

  def send_messages(path)
    loop do
      ChatbotChannel.send_message(room, path)
      break if path.input || path.next_step.nil?

      path = path.next_step
    end
    Rails.cache.write("#{room}_last_path", path.identifier)
    return unless path.finish

    send_messages BotPath.find_by(initial: true).next_step
  end

  def bad_option
    ChatbotChannel.custom_message(room, '**Error:** _Opción Inválida_', nil)
    send_messages BotPath.find_by(initial: true).next_step
  end

  def self.send_message(room, path)
    message = path.method_name ? path.send(path.method_name, room) : path.message
    data = {
      key: SecureRandom.uuid,
      from: 'bot',
      text: message,
      input: path.input
    }
    ActionCable.server.broadcast(room, { type: 'SetNewMessage', data: })
  end

  def self.custom_message(room, message, input)
    data = {
      key: SecureRandom.uuid,
      from: 'bot',
      text: message,
      input:
    }
    ActionCable.server.broadcast(room, { type: 'SetNewMessage', data: })
  end
end
