class User < ApplicationRecord
  AVATAR_COLORS = [
    "magenta",
    "orange",
    "gray",
    "gold",
    "turquoise",
    "teal",
    "lime",
    "brown",
    "yellow",
  ].freeze

  has_secure_password
  encrypts :email, :name
  blind_index :email, :name

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, presence: true, confirmation: true, length: { minimum: 13 }, if: :password
  validates :avatar_color, inclusion: { in: AVATAR_COLORS }, allow_nil: true

  has_many :user_projects, dependent: :destroy
  has_many :projects, through: :user_projects
  has_many :activities, dependent: :destroy
  has_many :todo_items, foreign_key: :user_id, dependent: :destroy

  # NOTE:
  # This method should only be used _inside_ more specifically named methods that control
  # user access to a specific feature or action, i.e. user.can_edit_project?(project).
  # Never just check a user role directly to decide if a feature should be shown!
  def is_admin_on?(project)
    user_projects.filter { |up| up.project_id == project.id }.first&.role == UserProject::ADMIN_ROLE
  end

  # https://github.com/basecamp/name_of_person/blob/master/lib/name_of_person/person_name.rb#L51-L54
  def initials
    name.remove(/(\(|\[).*(\)|\])/).scan(/([[:word:]])[[:word:]]*/i).join
  end

  def firstname_last_initial
    @firstname_last_initial ||= begin
      words_in_name = name.split
      words_in_name.one? ? name : "#{words_in_name.first} #{words_in_name.last.first}."
    end
  end

  def avatar_color
    super || "magenta"
  end
end
