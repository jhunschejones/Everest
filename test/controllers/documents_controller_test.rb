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

  describe "GET #application" do
    it "shows the resume page" do
      get application_path, params: { document: "Resume" }
      assert_response :success
      assert_select "h1.project-document-title", "Resume"
    end

    it "shows the cover letter page" do
      get application_path, params: { document: "Cover Letter" }
      assert_response :success
      assert_select "h1.project-document-title", "Cover Letter"
    end

    it "redirects to the project path for unrecognized job application document" do
      get application_path, params: { document: "Shopping List" }
      assert_redirected_to projects_path
    end
  end

  private

  def login_as(user)
    post login_path, params: { email: user.email, password: "secret" }
  end
end
