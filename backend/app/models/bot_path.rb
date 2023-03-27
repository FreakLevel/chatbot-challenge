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
    return '**Error:** _La fecha ingresada debe ser posterior al día de hoy_' if date <= Date.today

    last_deposit = client.account.last_deposit
    movements = client.account.account_movements
    movements = movements.where('created_at > ?', last_deposit) unless last_deposit.nil?

    "Tu depósito hasta este momento debería ser de: $#{client.account.payable}\n
| Moneda |                   Balance                    |
|--------|----------------------------------------------|
|  CLP   | #{movements.balance_currency(:clp).round(0)} |
|  USD   |     #{movements.balance_currency(:usd)}      |
|  EUR   |     #{movements.balance_currency(:eur)}      |"
  rescue Date::Error
    '**Error:** _La fecha ingresada no tiene el formato correcto_'
  end

  def send_economic_indicators(_room)
    indicators = CurrencyService.economic_indicators
    message = "Estos son los indicadores del día de hoy hasta este momento:\n
| Indicador | Valor |
|-----------|-------|"
    indicators.keys.inject(message) do |final_message, indicator|
      final_message + "\n|#{indicators[indicator][:code]}|#{indicators[indicator][:value]}|"
    end
  end

  def print_order_detail(room)
    rut = Rails.cache.read("#{room}_rut")
    address = Rails.cache.read("#{room}_address")
    quantity = Rails.cache.read("#{room}_quantity")
    "**Resumen de compra**\n
- Rut Cliente: #{rut}\n
- Dirección de entrega: #{address}\n
- Cantidad: #{quantity} x $700 CLP c/u\n
**Total:** _$#{quantity.to_i * 700} CLP_"
  end

  def create_order(room)
    rut = Rails.cache.read("#{room}_rut")
    client = Client.find_by(rut:)
    return "**Error:** _Cliente con rut #{rut} no se encuentra registrado_" if client.nil?

    address = Rails.cache.read("#{room}_address")
    quantity = Rails.cache.read("#{room}_quantity")
    total = quantity.to_i * 700
    if client.account.payable < total
      return '**Error:** _No posee saldo suficiente en su cuenta para realizar la compra_'
    end

    movement = client.account.account_movements.new
    movement.movement_type = :expense
    movement.currency = :clp
    movement.amount = total
    movement.description = "Compra #{quantity} rollos de papel - Dirección: #{address}"
    date = DateTime.now.midnight + 1.day
    movement.created_at = date
    movement.updated_at = date
    movement.save!
    "## ¡Tu orden ha sido creada con éxito!\n
__El total de la compra será descontado de tu saldo de mañana__"
  end
end
