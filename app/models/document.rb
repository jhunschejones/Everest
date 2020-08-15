class Document < ApplicationRecord
  belongs_to :project
  has_rich_text :content

  scope :ordered, -> { order({ created_at: :desc }) }
  scope :for_documents_list, -> { where.not(title: [RESUME, COVER_LETTER]) }

  RESUME = "Resume".freeze
  COVER_LETTER = "Cover Letter".freeze
  VALID_APPLICATION_DOCS = [Document::RESUME, Document::COVER_LETTER]

  def self.for_application(document_title)
    formatted_document_title = document_title.strip.titleize
    return nil unless VALID_APPLICATION_DOCS.include?(formatted_document_title)
    Document.find_by(title: formatted_document_title)
  end

  def is_for_application?
    VALID_APPLICATION_DOCS.include?(title.strip.titleize)
  end
end
