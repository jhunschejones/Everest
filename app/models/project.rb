class Project < ApplicationRecord
  has_many :user_projects, dependent: :destroy
  has_many :users, through: :user_projects
  has_many :activities, dependent: :destroy
  has_many :project_tools, dependent: :destroy
  has_many :documents, dependent: :destroy
  has_many :todo_lists, dependent: :destroy

  validates :name, presence: true
end
