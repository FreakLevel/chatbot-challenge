# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id             :bigint           not null, primary key
#  account_number :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  clients_id     :bigint           not null
#
class Account < ApplicationRecord
  belongs_to :client, dependent: :destroy
  has_many :account_movements, as: movements, dependent: :destroy
end
