class AddAvatarColorToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :avatar_color, :string
  end
end
