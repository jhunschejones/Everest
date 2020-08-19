require 'test_helper'

# bundle exec ruby -Itest test/controllers/documents_controller_test.rb
class DocumentsControllerTest < ActionDispatch::IntegrationTest
  describe "GET #index" do
    describe "with a project_id" do
      it "loads the project documents page" do
        get project_documents_path(projects(:everest))
        assert_response :success
        assert_select "h1.project-documents-title", "Docs & Files"
      end

      it "shows project document breadcrumbs" do
        get project_documents_path(projects(:everest))
        assert_select "div.project-breadcrumb"
      end

      it "does not include resume or cover letter" do
        get project_documents_path(projects(:everest))
        assert_select "h4.document-title", text: "Resume", count: 0
        assert_select "h4.document-title", text: "Cover Letter", count: 0
      end
    end

    describe "without a project_id" do
      it "loads the documents page" do
        get documents_path
        assert_response :success
        assert_select "h1.project-documents-title", "Docs & Files"
      end

      it "does not show project document breadcrumbs" do
        get documents_path
        assert_select "div.project-breadcrumb", count: 0
      end

      it "does not include resume or cover letter" do
        get documents_path
        assert_select "h4.document-title", text: "Resume", count: 0
        assert_select "h4.document-title", text: "Cover Letter", count: 0
      end
    end
  end

  describe "GET #show" do
    it "loads the project document page" do
      get project_document_path(projects(:everest), documents(:blog_post))
      assert_response :success
      assert_select "h1.project-document-title", documents(:blog_post).title
    end

    describe "when document is for basecamp" do
      it "redirects resume to basecamp document page" do
        get project_document_path(projects(:everest), documents(:resume))
        assert_redirected_to basecamp_path(document: "Resume")
        follow_redirect!
        assert_response :success
        assert_select "h1.project-document-title", documents(:resume).title
      end

      it "redirects cover letter to basecamp document page" do
        get project_document_path(projects(:everest), documents(:cover_letter))
        assert_redirected_to basecamp_path(document: "Cover Letter")
        follow_redirect!
        assert_response :success
        assert_select "h1.project-document-title", documents(:cover_letter).title
      end
    end
  end

  describe "GET #new" do
    describe "when no user is logged in" do
      it "redirects to the login page page" do
        get new_project_document_path(projects(:everest))
        assert_redirected_to login_path
      end
    end

    describe "when an admin user is logged in" do
      before do
        login_as(users(:project_admin))
      end

      it "shows the new project documents page" do
        get new_project_document_path(projects(:everest))
        assert_response :success
        assert_select "h2.title", "New document"
      end
    end
  end

  describe "GET #edit" do
    describe "when no user is logged in" do
      it "redirects to the login page page" do
        get edit_project_document_path(projects(:everest), documents(:blog_post))
        assert_redirected_to login_path
      end
    end

    describe "when an admin user is logged in" do
      before do
        login_as(users(:project_admin))
      end

      it "shows the edit project document page" do
        get edit_project_document_path(projects(:everest), documents(:blog_post))
        assert_response :success
        assert_select "h2.title", "Edit document"
        assert_select "input" do
          assert_select "[value=?]", documents(:blog_post).title
        end
      end
    end
  end

  describe "POST #create" do
    describe "when no user is logged in" do
      it "does not create a new project document" do
        assert_no_difference "Document.count" do
          post project_documents_path(projects(:everest)), params: { document: { title: "My new document" } }
        end
      end

      it "redirects to the login page page" do
        post project_documents_path(projects(:everest)), params: { document: { title: "My new document" } }
        assert_redirected_to login_path
      end
    end

    describe "when an admin user is logged in" do
      before do
        login_as(users(:project_admin))
      end

      it "creates a new project document" do
        assert_difference "Document.count", 1 do
          post project_documents_path(projects(:everest)), params: { document: { title: "My new document" } }
        end
        assert_equal "My new document", Document.last.title
      end

      it "redirects to the project document page" do
        post project_documents_path(projects(:everest)), params: { document: { title: "My new document" } }
        assert_redirected_to project_document_path(projects(:everest), Document.last)
      end
    end
  end

  describe "PATCH #update" do
    describe "when no user is logged in" do
      it "does not update the project document record" do
        assert_no_changes -> { Document.find(documents(:blog_post).id).title } do
          patch project_document_path(projects(:everest), documents(:blog_post)), params: { document: { title: "Change the title" } }
        end
      end

      it "redirects to the login page page" do
        patch project_document_path(projects(:everest), documents(:blog_post)), params: { document: { title: "Change the title" } }
        assert_redirected_to login_path
      end
    end

    describe "when an admin user is logged in" do
      before do
        login_as(users(:project_admin))
      end

      it "updates the project document record" do
        assert_changes -> { Document.find(documents(:blog_post).id).title } do
          patch project_document_path(projects(:everest), documents(:blog_post)), params: { document: { title: "Change the title" } }
        end
        assert_equal "Change the title", Document.find(documents(:blog_post).id).title
      end

      it "redirects to the project document page" do
        patch project_document_path(projects(:everest), documents(:blog_post)), params: { document: { title: "Change the title" } }
        assert_redirected_to project_document_path(projects(:everest), documents(:blog_post))
      end
    end
  end

  describe "GET #basecamp" do
    it "shows the resume page" do
      get basecamp_path, params: { document: "Resume" }
      assert_response :success
      assert_select "h1.project-document-title", "Resume"
    end

    it "shows the cover letter page" do
      get basecamp_path, params: { document: "Cover Letter" }
      assert_response :success
      assert_select "h1.project-document-title", "Cover Letter"
    end

    it "redirects to the project path for unrecognized job basecamp document" do
      get basecamp_path, params: { document: "Shopping List" }
      assert_redirected_to projects_path
    end
  end

  describe "GET #application_edit" do
    describe "when no user is logged in" do
      it "redirects to the login page page" do
        get basecamp_edit_path, params: { document: "Cover Letter" }
        assert_redirected_to login_path
      end
    end

    describe "when an admin user is logged in" do
      before do
        login_as(users(:project_admin))
      end

      describe "when the document is not for basecamp" do
        it "redirects to the projects path" do
          get basecamp_edit_path, params: { document: "Shopping List" }
          assert_redirected_to projects_path
        end
      end

      describe "when the document is for basecamp" do
        it "shows the edit project document page for the resume" do
          get basecamp_edit_path, params: { document: "Resume" }
          assert_redirected_to edit_project_document_path(projects(:everest), documents(:resume))
          follow_redirect!
          assert_response :success
          assert_select "h2.title", "Edit document"
          assert_select "input" do
            assert_select "[value=?]", documents(:resume).title
          end
        end

        it "shows the edit project document page for the cover letter" do
          get basecamp_edit_path, params: { document: "Cover Letter" }
          assert_redirected_to edit_project_document_path(projects(:everest), documents(:cover_letter))
          follow_redirect!
          assert_response :success
          assert_select "h2.title", "Edit document"
          assert_select "input" do
            assert_select "[value=?]", documents(:cover_letter).title
          end
        end
      end
    end
  end

  private

  def login_as(user)
    post login_path, params: { email: user.email, password: "secret" }
  end
end
