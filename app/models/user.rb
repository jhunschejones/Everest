class User < ApplicationRecord
  has_secure_password
  encrypts :email, :name
  blind_index :email, :name

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, presence: true

  has_many :user_projects, dependent: :destroy
  has_many :projects, through: :user_projects
  has_many :activities, dependent: :destroy
end
