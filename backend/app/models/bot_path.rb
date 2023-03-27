# == Schema Information
#
# Table name: bot_paths
#
#  id             :bigint           not null, primary key
#  initial        :boolean          default(FALSE), not null
#  identifier     :string           not null
#  message        :text             default(""), not null
#  input          :string
#  options        :jsonb
#  finish         :boolean          default(FALSE), not null
#  method_name    :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  next_step_id   :bigint
#  parent_step_id :bigint
#
class BotPath < ApplicationRecord
  has_one :next_step, class_name: 'BotPath', foreign_key: 'parent_step_id'
  belongs_to :parent_step, class_name: 'BotPath', optional: true

  before_save { self.identifier = SecureRandom.uuid }

  def calculate_deposit(room)
    rut = Rails.cache.read("#{room}_rut")
    client = Client.find_by(rut:)
    return "**Error:** _Cliente con rut #{rut} no se encuentra registrado_" if client.nil?

    date = Date.strptime(Rails.cache.read("#{room}_date"), '%d/%m/%Y')
    return '**Error:** _La fecha ingresada debe ser posterior al día de hoy_' if date < Date.today

    "Tu depósito hasta este momento debería ser de: $#{client.account.payable}\n
    | Moneda |                     Balance                        |
    |--------|----------------------------------------------------|
    |  CLP   | #{client.account.movements.balance_currency(:clp)} |
    |  USD   | #{client.account.movements.balance_currency(:usd)} |
    |  EUR   | #{client.account.movements.balance_currency(:eur)} |"
  end
end
