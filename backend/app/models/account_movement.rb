# frozen_string_literal: true

# == Schema Information
#
# Table name: account_movements
#
#  id            :bigint           not null, primary key
#  identifier    :string           not null
#  movement_type :integer          default("expense"), not null
#  amount        :float            default(0.0), not null
#  currency      :integer          default("clp"), not null
#  description   :string           default(""), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  account_id    :bigint           not null
#
class AccountMovement < ApplicationRecord
  belongs_to :account

  enum movement_type: {
    expense: 0,
    income: 1
  }

  enum currency: {
    clp: 0,
    usd: 1,
    eur: 2
  }, _prefix: true

  scope :balance_currency, lambda { |currency|
    where(currency:).inject(0) do |total, movement|
      amount = movement.amount.to_f
      amount *= -1 if movement.expense?
      total + amount
    end
  }

  before_save { self.amount = amount.to_f.round(2) }
end
