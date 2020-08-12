class ActivitiesController < ApplicationController
  skip_before_action :authenticate_user, only: [:index]
  before_action :set_activity_and_project, except: [:index, :new, :create]

  def index
    @activities_by_month_and_year =
      if params[:project_id].blank?
        Activity.all.includes(:project, :user)
      else
        Activity.where(project_id: params[:project_id]).includes(:user)
      end.ordered.group_by(&:month_and_year)
  end

  def new
    @activity = Activity.new
    @project = Project.find(params[:project_id])
  end

  def edit
  end

  def create
    @activity = Activity.create(
      activity_params
        .except(:created_at)
        .merge({
          project_id: params[:project_id],
          user_id: @current_user.id
        })
    )
    redirect_to project_path(params[:project_id])
  end

  def update
    @activity.update(activity_params)
    redirect_to project_path(@project)
  end

  private

  def activity_params
    params.require(:activity).permit(:title, :created_at)
  end

  def set_activity_and_project
    @activity = Activity.find(params[:id])
    @project = Project.find(params[:project_id])
  end
end
