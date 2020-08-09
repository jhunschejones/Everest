class DocumentsController < ApplicationController
  skip_before_action :authenticate_user, only: [:index, :show, :application]
  before_action :set_document_and_project, except: [:index, :new, :create, :application]

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
  end

  def new
    @document = Document.new
    @project = Project.find(params[:project_id])
  end

  def edit
  end

  def create
    @document = Document.create(
      document_params
        .except(:created_at)
        .merge({ project_id: params[:project_id] })
    )
    redirect_to project_document_path(@document.project, @document)
  end

  def update
    @document.update(document_params)
    redirect_to project_document_path(@project, @document)
  end

  def application
    application_document_title = params[:document].strip.titleize
    if application_document_title == Document::RESUME
      @document = Document.find_by(title: Document::RESUME)
    elsif application_document_title == Document::COVER_LETTER
      @document = Document.find_by(title: Document::COVER_LETTER)
    else
      redirect_to projects_path
    end
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
