class TodoListsController < ApplicationController
  skip_before_action :authenticate_user, only: [:index, :show]
  before_action :set_todo_list_and_project, only: [:show, :edit, :update]

  def index
    @todo_lists =
      if params[:project_id].blank?
        TodoList.includes(todo_items: [:assigned_to]).ordered.all
      else
        TodoList.includes(todo_items: [:assigned_to]).where(project_id: params[:project_id]).ordered
      end
    @project = Project.find(params[:project_id]) if params[:project_id]
  end

  def show
    @completion_chart_data = @todo_list.completion_chart_data
  end

  def new
    @todo_list = TodoList.new
    @project = Project.find(params[:project_id])
  end

  def edit
  end

  def create
    @todo_list = TodoList.create(todo_list_params.merge({ project_id: params[:project_id] }))
    redirect_to project_todo_list_path(@todo_list.project_id, @todo_list)
  end

  def update
    @todo_list.update(todo_list_params)
    redirect_to project_todo_list_path(@todo_list.project_id, @todo_list)
  end

  private

  def todo_list_params
    params.require(:todo_list).permit(:name, :order, :created_at)
  end

  def set_todo_list_and_project
    @todo_list = TodoList.includes(todo_items: [:assigned_to]).find(params[:id])
    @project = Project.find(params[:project_id])
  end
end
