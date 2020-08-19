class DocumentsController < ApplicationController
  skip_before_action :authenticate_user, only: [:index, :show, :basecamp]
  before_action :set_document_and_project, only: [:show, :edit, :update]

  def index
    @documents =
      if params[:project_id]
        Document.where(project_id: params[:project_id])
      else
        Document.all.includes(:project)
      end.for_documents_list.ordered

    @project = Project.find(params[:project_id]) if params[:project_id]
  end

  def show
    return redirect_to basecamp_path(document: @document.title) if @document.is_for_basecamp?
  end

  def new
    @document = Document.new
    @project = Project.find(params[:project_id])
  end

  def edit
  end

  def create
    @document = Document.create(document_params.merge({ project_id: params[:project_id] }))
    redirect_to project_document_path(@document.project, @document)
  end

  def update
    @document.update(document_params)
    redirect_to project_document_path(@project, @document)
  end

  def basecamp
    @document = Document.for_basecamp(params[:document])
    redirect_to projects_path unless @document.present?
  end

  def basecamp_edit
    @document = Document.for_basecamp(params[:document])
    return redirect_to projects_path unless @document.present?
    redirect_to edit_project_document_path(@document.project_id, @document.id)
  end

  private

  def document_params
    params.require(:document).permit(:title, :content, :created_at)
  end

  def set_document_and_project
    @document = Document.find(params[:id])
    @project = Project.find(params[:project_id])
  end
end
