# frozen_string_literal: true

# == Schema Information
#
# Table name: account_movements
#
#  id            :bigint           not null, primary key
#  identifier    :string           not null
#  movement_type :integer          default(0), not null
#  amount        :float            default(0.0), not null
#  currency      :integer          default(0), not null
#  description   :string           default(""), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  accounts_id   :bigint           not null
#
class AccountMovement < ApplicationRecord
  belongs_to :accounts, dependent: :destroy

  enum movement_type: {
    expense: 0,
    income: 1
  }, _prefix: true

  enum currency: {
    clp: 0,
    usd: 1,
    eur: 2
  }, _prefix: true
end
