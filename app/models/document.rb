class Document < ApplicationRecord
  belongs_to :project
  has_rich_text :content

  scope :ordered, -> { order({ created_at: :desc }) }
  scope :for_documents_list, -> { where.not(title: [RESUME, COVER_LETTER]) }

  RESUME = "Resume".freeze
  COVER_LETTER = "Cover Letter".freeze
end
