# frozen_string_literal: true

class CreateAccountMovements < ActiveRecord::Migration[7.0]
  def change
    create_table :account_movements do |t|
      t.string :identifier, null: false, unique: true
      t.integer :movement_type, null: false, default: 0
      t.float :amount, null: false, default: 0
      t.integer :currency, null: false, default: 0
      t.string :description, null: false, default: ''
      t.timestamps
    end
    add_index :account_movements, :identifier, unique: true
    add_reference :account_movements, :accounts, null: false, index: { unique: true }
  end
end
