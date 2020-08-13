require 'test_helper'

# bundle exec ruby -Itest test/models/document_test.rb
class DocumentTest < ActiveSupport::TestCase
  describe ".for_application" do
    it "returns nil for invalid application document title" do
      assert_nil Document.for_application("Shopping List")
    end

    it "returns resume" do
      assert_equal documents(:resume), Document.for_application("Resume")
      assert_equal documents(:resume), Document.for_application("  resume    ")
    end

    it "returns cover letter" do
      assert_equal documents(:cover_letter), Document.for_application("Cover Letter")
      assert_equal documents(:cover_letter), Document.for_application("  cover_letter   ")
    end
  end

  describe ".for_documents_list" do
    it "does not return resume" do
      refute Document.all.for_documents_list.include?(documents(:resume)), "resume should not be returned for documents list"
    end

    it "does not return cover letter" do
      refute Document.all.for_documents_list.include?(documents(:cover_letter)), "cover letter should not be returned for documents list"
    end
  end
end
