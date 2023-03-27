# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id             :bigint           not null, primary key
#  account_number :string           not null
#  last_deposit   :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  client_id      :bigint           not null
#
class Account < ApplicationRecord
  belongs_to :client, dependent: :destroy
  has_many :account_movements, dependent: :destroy

  before_create :generate_account_number

  def payable
    eur_value = CurrencyService.eur_value
    usd_value = CurrencyService.usd_value
    movements = if last_deposit.nil?
                  account_movements
                else
                  account_movements.where('created_at > ?', last_deposit)
                end
    clp_balance = movements.balance_currency(:clp)
    usd_balance = movements.balance_currency(:usd)
    eur_balance = movements.balance_currency(:eur)
    clp_balance + (usd_value * usd_balance) + (eur_value * eur_balance)
  end

  private

  def generate_account_number
    while account_number.nil?
      first_number = rand(1..9)
      self.account_number = "#{first_number}#{9.times.map { rand(10) }.join}"
      self.account_number = nil if Account.find_by(account_number:).present?
    end
  end
end
