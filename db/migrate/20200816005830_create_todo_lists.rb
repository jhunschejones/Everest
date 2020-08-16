class CreateTodoLists < ActiveRecord::Migration[6.0]
  def change
    create_table :todo_lists do |t|
      t.string :name, null: false
      t.integer :order, default: 0
      t.references :project, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
