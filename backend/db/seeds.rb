# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Generate Clients and their accounts

client1 = Client.create(rut: '6072870-4', name: 'Aleksander Knox')
client2 = Client.create(rut: '6943021-K', name: 'Amie Haney')

# Client 1 movements
date = Date.today - 5.months
while date < Date.today
  date += rand(10).days
  client1.account.account_movements.create(
    movement_type: 1,
    identifier: SecureRandom.uuid,
    amount: rand(1..10_000),
    currency: rand(0..2),
    description: 'Venta'
  )
  next if date.day < 25

  amount = client1.account.payable
  client1.account.account_movements.create(
    movement_type: 0,
    identifier: SecureRandom.uuid,
    amount:,
    currency: 0,
    description: 'Deposito'
  )
  client1.account.update(last_deposit: date)
end

# Client 2 movements
date = Date.today - 1.months
while date < Date.today
  date += rand(7).days
  client2.account.account_movements.create(
    movement_type: 1,
    identifier: SecureRandom.uuid,
    amount: rand(1..10_000),
    currency: rand(0..2),
    description: 'Venta'
  )
end

# Bot path
# # Consult of deposit
consult_deposit = BotPath.new
consult_deposit.message = 'Ingrese su rut (Ej: 11111111-1)'
consult_deposit.input = 'rut'
consult_deposit.save
date_deposit = consult_deposit.build_next_step
date_deposit.message = 'Ingrese la fecha a consultar (Ej: DD/MM/YYYY)'
date_deposit.input = 'date'
date_deposit.save
response_deposit = date_deposit.build_next_step
response_deposit.method_name = 'calculate_deposit'
response_deposit.finish = true
response_deposit.save
# # Menu
initial_path = BotPath.new
initial_path.initial = true
initial_path.message = '### Bienvenido, estoy aquí para ayudarte a resolver algunas dudas'
initial_path.save
menu_path = initial_path.build_next_step
menu_path.message = "Envía el número de la acción en que deseas que te ayude.\n
1. Consulta de Depósito"
menu_path.input = ''
menu_path.options = { '1': consult_deposit.identifier }
menu_path.save
