class ProjectToolsController < ApplicationController
  before_action :set_project_and_project_tool, except: [:new, :create]

  def new
    @project_tool = ProjectTool.new
    @project = Project.find(params[:project_id])
  end

  def edit
  end

  def create
    ProjectTool.create(
      project_tool_params.merge({ project_id: params[:project_id] })
    )
    redirect_to project_path(params[:project_id])
  end

  def update
    @project_tool.update(project_tool_params)
    redirect_to project_path(@project)
  end

  private

  def project_tool_params
    params.require(:project_tool).permit(:name, :link, :image_name, :content_preview)
  end

  def set_project_and_project_tool
    @project_tool = ProjectTool.find(params[:id])
    @project = Project.find(params[:project_id])
  end
end
