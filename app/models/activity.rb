class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :project

  scope :ordered, -> { order({ created_at: :desc }) }

  def month_and_year
    created_at.localtime.strftime("%B %Y")
  end
end
