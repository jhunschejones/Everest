class ProjectsController < ApplicationController
  skip_before_action :authenticate_user, only: [:index, :show]
  before_action :set_project, except: [:index, :new, :create]

  def index
    @projects = Project.all.order({ created_at: :desc })
  end

  def show
    @activities_by_month_and_year = @project.activities.ordered.group_by(&:month_and_year)
    @recent_documents = Document
      .for_documents_list
      .where(project: @project)
      .order({ updated_at: :desc })
      .limit(2)
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.create(project_params.except(:created_at))
    redirect_to project_path(@project)
  end

  def update
    @project.update(project_params)
    redirect_to project_path(@project)
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :created_at)
  end

  def set_project
    @project = Project.includes(:project_tools, activities: [:user]).find(params[:id])
  end
end
