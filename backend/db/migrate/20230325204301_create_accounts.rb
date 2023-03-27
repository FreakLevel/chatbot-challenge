# frozen_string_literal: true

class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :account_number, null: false, unique: true
      t.datetime :last_deposit
      t.timestamps
    end
    add_index :accounts, :account_number, unique: true
    add_reference :accounts, :client, null: false, index: { unique: true }
  end
end
