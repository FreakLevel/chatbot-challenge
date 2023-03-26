# frozen_string_literal: true

require 'securerandom'

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :room

    def connect
      self.room = SecureRandom.uuid
    end
  end
end
