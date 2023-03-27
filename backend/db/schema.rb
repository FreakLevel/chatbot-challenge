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

ActiveRecord::Schema[7.0].define(version: 2023_03_26_120554) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_movements", force: :cascade do |t|
    t.string "identifier", null: false
    t.integer "movement_type", default: 0, null: false
    t.float "amount", default: 0.0, null: false
    t.integer "currency", default: 0, null: false
    t.string "description", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "account_id", null: false
    t.index ["account_id"], name: "index_account_movements_on_account_id"
    t.index ["identifier"], name: "index_account_movements_on_identifier", unique: true
  end

  create_table "accounts", force: :cascade do |t|
    t.string "account_number", null: false
    t.datetime "last_deposit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "client_id", null: false
    t.index ["account_number"], name: "index_accounts_on_account_number", unique: true
    t.index ["client_id"], name: "index_accounts_on_client_id", unique: true
  end

  create_table "bot_paths", force: :cascade do |t|
    t.boolean "initial", default: false, null: false
    t.string "identifier", null: false
    t.text "message", default: "", null: false
    t.string "input"
    t.jsonb "options"
    t.boolean "finish", default: false, null: false
    t.string "method_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "next_step_id"
    t.bigint "parent_step_id"
    t.index ["next_step_id"], name: "index_bot_paths_on_next_step_id"
    t.index ["parent_step_id"], name: "index_bot_paths_on_parent_step_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "rut", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rut"], name: "index_clients_on_rut", unique: true
  end

  add_foreign_key "bot_paths", "bot_paths", column: "next_step_id"
  add_foreign_key "bot_paths", "bot_paths", column: "parent_step_id"
end
