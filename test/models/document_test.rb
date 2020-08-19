require 'test_helper'

# bundle exec ruby -Itest test/models/document_test.rb
class DocumentTest < ActiveSupport::TestCase
  describe ".for_documents_list" do
    it "does not return resume" do
      refute Document.all.for_documents_list.include?(documents(:resume)), "resume should not be returned for documents list"
    end

    it "does not return cover letter" do
      refute Document.all.for_documents_list.include?(documents(:cover_letter)), "cover letter should not be returned for documents list"
    end
  end

  describe ".for_basecamp" do
    it "returns nil for invalid basecamp document title" do
      assert_nil Document.for_basecamp("Shopping List")
    end

    it "returns resume" do
      assert_equal documents(:resume), Document.for_basecamp("Resume")
      assert_equal documents(:resume), Document.for_basecamp("  resume    ")
    end

    it "returns cover letter" do
      assert_equal documents(:cover_letter), Document.for_basecamp("Cover Letter")
      assert_equal documents(:cover_letter), Document.for_basecamp("  cover_letter   ")
    end
  end

  describe "#is_for_basecamp?" do
    it "returns false for invalid basecamp document title" do
      refute Document.new(title: "Shopping List").is_for_basecamp?
    end

    it "returns true for resume" do
      assert documents(:resume).is_for_basecamp?
    end

    it "returns true for cover letter" do
      assert documents(:cover_letter).is_for_basecamp?
    end
  end
end
