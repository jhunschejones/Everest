class CreateTodoItems < ActiveRecord::Migration[6.0]
  def change
    create_table :todo_items do |t|
      t.text :description, null: false
      t.text :notes
      t.boolean :is_complete, default: false
      t.datetime :due_on
      t.integer :order, default: 0
      t.references :todo_list, null: false, foreign_key: { on_delete: :cascade }
      t.references :assigned_to, index: true, foreign_key: { to_table: :users, on_delete: :cascade }

      t.timestamps
    end
  end
end
