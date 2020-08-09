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

  def is_admin?
    site_role == SITE_ADMIN
  end

  # https://github.com/basecamp/name_of_person/blob/master/lib/name_of_person/person_name.rb#L51-L54
  def initials
    name.remove(/(\(|\[).*(\)|\])/).scan(/([[:word:]])[[:word:]]*/i).join
  end
end
