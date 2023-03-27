class CreateBotPaths < ActiveRecord::Migration[7.0]
  def change
    create_table :bot_paths do |t|
      t.boolean :initial, null: false, default: false
      t.string :identifier, null: false, unique: true
      t.text :message, null: false, default: ''
      t.string :input, null: true, default: nil
      t.jsonb :options, null: true, default: nil
      t.boolean :finish, null: false, default: false
      t.string :method_name, null: true, default: nil
      t.timestamps
    end
    add_reference :bot_paths,
                  :next_step,
                  null: true,
                  foreign_key: {
                    to_table: :bot_paths
                  }
    add_reference :bot_paths,
                  :parent_step,
                  null: true,
                  foreign_key: {
                    to_table: :bot_paths
                  }
  end
end
