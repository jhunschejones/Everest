class AddImageNameToProjectTool < ActiveRecord::Migration[6.0]
  def change
    add_column :project_tools, :image_name, :string
  end
end
