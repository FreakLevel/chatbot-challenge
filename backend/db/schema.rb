# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_230_325_210_800) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'account_movements', force: :cascade do |t|
    t.string 'identifier', null: false
    t.integer 'movement_type', default: 0, null: false
    t.float 'amount', default: 0.0, null: false
    t.integer 'currency', default: 0, null: false
    t.string 'description', default: '', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'accounts_id', null: false
    t.index ['accounts_id'], name: 'index_account_movements_on_accounts_id', unique: true
    t.index ['identifier'], name: 'index_account_movements_on_identifier', unique: true
  end

  create_table 'accounts', force: :cascade do |t|
    t.string 'account_number', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'clients_id', null: false
    t.index ['account_number'], name: 'index_accounts_on_account_number', unique: true
    t.index ['clients_id'], name: 'index_accounts_on_clients_id', unique: true
  end

  create_table 'clients', force: :cascade do |t|
    t.string 'rut', null: false
    t.string 'name', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['rut'], name: 'index_clients_on_rut', unique: true
  end
end
