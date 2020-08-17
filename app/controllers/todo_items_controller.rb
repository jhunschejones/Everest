class TodoItemsController < ApplicationController
  skip_before_action :authenticate_user, only: [:index, :show, :update]
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
    redirect_to project_todo_list_todo_item_path(@todo_list.project_id, @todo_list, @todo_item)
  end

  # WARNING: Intentionally skipping `authenticate_user` in this action to allow
  # unauthenticated users to play with the `is_complete` checkboxes via JS request.
  # As a result, the user has to be manually authenticated for html PATCH requests
  # where all attributes are accepted.
  def update
    respond_to do |format|
      format.js {
        # Only allowing the `is_complete` attribute to be updated here since this
        # path intentionally skips user authentication.
        @todo_item.update(is_complete: todo_item_params[:is_complete])
        @completion_chart_data = @todo_list.completion_chart_data
      }
      format.html {
        # Performing the same check here as `authenticate_user` normally does since
        # this path allows all todo_item attributes to be updated.
        unless User.find_by(id: session[:user_id])
          return redirect_to login_url, notice: "You do not have permission to access that page"
        end
        @todo_item.update(todo_item_params)
        redirect_to project_todo_list_todo_item_path(@todo_list.project_id, @todo_list, @todo_item)
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
