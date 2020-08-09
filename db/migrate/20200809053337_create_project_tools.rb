class CreateProjectTools < ActiveRecord::Migration[6.0]
  def change
    create_table :project_tools do |t|
      t.string :name, null: false
      t.string :link, null: false
      t.text :content_preview
      t.references :project, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
