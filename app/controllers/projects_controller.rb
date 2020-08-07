class ProjectsController < ApplicationController
  skip_before_action :authenticate_user, only: [:index, :show]
  before_action :set_project, except: [:index, :new, :create]

  def index
    @projects = Project.all
  end

  def show
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
    @project = Project.find(params[:id])
  end
end
