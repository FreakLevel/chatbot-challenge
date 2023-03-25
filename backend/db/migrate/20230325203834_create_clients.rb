# frozen_string_literal: true

class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :rut, null: false, unique: true
      t.string :name, null: false
      t.timestamps
    end
    add_index :clients, :rut, unique: true
  end
end
