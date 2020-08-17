class TodoItemsController < ApplicationController
  skip_before_action :authenticate_user, only: [:index, :show]
  before_action :set_todo_list
  before_action :set_todo_item, only: [:show, :edit, :update]
  before_action :set_project, only: [:show, :new, :edit]

  def show
  end

  def new
    @todo_item = TodoItem.new
    @users = @project.users
  end

  def edit
    @users = @project.users
  end

  def create
    @todo_item = TodoItem.create(todo_item_params.merge({ todo_list: @todo_list }))
    redirect_to project_todo_list_path(@todo_list.project_id, @todo_list)
  end

  def update
    @todo_item.update(todo_item_params)
    @completion_chart_data = @todo_list.completion_chart_data

    respond_to do |format|
      format.js
      format.html {
        redirect_to project_todo_list_path(@todo_list.project_id, @todo_list)
      }
    end
  end

  private

  def set_todo_item
    @todo_item = TodoItem.find(params[:id])
  end

  def set_project
    @project = Project.includes(:users).find(params[:project_id])
  end

  def set_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  def todo_item_params
    params.require(:todo_item).permit(:description, :notes, :assigned_to_id, :order, :is_complete, :due_on, :created_at)
  end
end
