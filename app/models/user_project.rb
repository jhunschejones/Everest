class UserProject < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validate :project_role_valid
  validates_uniqueness_of :user_id, { scope: :project_id, message: "%{value} already has a user_project record for this project" }

  ADMIN_ROLE = "admin".freeze
  USER_ROLE = "user".freeze
  VALID_USER_PROJECT_ROLES = [ADMIN_ROLE, USER_ROLE].freeze

  private

  def project_role_valid
    unless VALID_USER_PROJECT_ROLES.include?(role)
      errors.add(:role, "not included in '#{VALID_USER_PROJECT_ROLES}'")
    end
  end
end
