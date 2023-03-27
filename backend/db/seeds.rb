# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Generate Clients and their accounts
puts 'Clients'
client1 = Client.create(rut: '6072870-4', name: 'Aleksander Knox')
client2 = Client.create(rut: '6943021-K', name: 'Amie Haney')

puts 'Client 1 movements'
# Client 1 movements
date = Date.today - 5.months
while date < Date.today
  client1.account.account_movements.create(
    movement_type: 1,
    identifier: SecureRandom.uuid,
    amount: rand(1..10_000),
    currency: rand(0..2),
    description: 'Venta'
  )
  last_date = date
  date += rand(10).days
  next if last_date.day < 25

  amount = client1.account.payable
  client1.account.account_movements.create(
    movement_type: 0,
    identifier: SecureRandom.uuid,
    amount:,
    currency: 0,
    description: 'Deposito'
  )
  client1.account.update(last_deposit: last_date)
end

puts 'Client 2 movements'
# Client 2 movements
date = Date.today - 1.months
while date < Date.today
  client2.account.account_movements.create(
    movement_type: 1,
    identifier: SecureRandom.uuid,
    amount: rand(1..10_000),
    currency: rand(0..2),
    description: 'Venta'
  )
  date += rand(7).days
end

puts 'Building paths'
# Bot path
puts 'Consult of deposit'
# # Consult of deposit
consult_deposit = BotPath.new
consult_deposit.message = 'Ingrese su rut (Ej: 11111111-1)'
consult_deposit.input = 'rut'
consult_deposit.save!
date_deposit = consult_deposit.build_next_step
date_deposit.message = 'Ingrese la fecha a consultar (Ej: DD/MM/YYYY)'
date_deposit.input = 'date'
date_deposit.save!
response_deposit = date_deposit.build_next_step
response_deposit.method_name = 'calculate_deposit'
response_deposit.finish = true
response_deposit.save!
puts 'Economic indicators'
# # Request Paper
request_paper = BotPath.new
request_paper.message = 'Cada rollo de papel tiene un valor de $700 CLP'
request_paper.save!
require_rut = request_paper.build_next_step
require_rut.message = 'Ingrese su rut (Ej: 11111111-1)'
require_rut.input = 'rut'
require_rut.save!
require_address = require_rut.build_next_step
require_address.message = 'Ingrese la dirección de entrega'
require_address.input = 'address'
require_address.save!
require_quantity = require_address.build_next_step
require_quantity.message = 'Cantidad de rollos:'
require_quantity.input = 'quantity'
require_quantity.save!
order_detail = require_quantity.build_next_step
order_detail.method_name = 'print_order_detail'
order_detail.save!
confirm_order = order_detail.build_next_step
confirm_order.message = "¿Desea confirmar su orden?\n
1. Si
2. No"
confirm_order.input = ''
confirm_order.save!
order = BotPath.new
order.method_name = 'create_order'
order.finish = true
order.save!
cancelled_order = BotPath.new
cancelled_order.message = '**La orden ha sido cancelada**'
cancelled_order.finish = true
cancelled_order.save!
confirm_order.options = {
  '1': order.identifier,
  '2': cancelled_order.identifier
}
confirm_order.save!
# # Economic Indicators
economic_indicators = BotPath.new
economic_indicators.method_name = 'send_economic_indicators'
economic_indicators.finish = true
economic_indicators.save!
puts 'Menu'
# # Menu
initial_path = BotPath.new
initial_path.initial = true
initial_path.message = '### Bienvenido, estoy aquí para ayudarte a resolver algunas dudas'
initial_path.save!
menu_path = initial_path.build_next_step
menu_path.message = "Envía el número de la acción en que deseas que te ayude.\n
1. Consulta de Depósito
2. Solicitud rollos de papel
3. Consulta Indicadores Económicos"
menu_path.input = ''
menu_path.options = {
  '1': consult_deposit.identifier,
  '2': request_paper.identifier,
  '3': economic_indicators.identifier
}
menu_path.save!
