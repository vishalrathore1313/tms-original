class TasksController < ApplicationController
  before_action :set_project
  before_action :set_task, only: [:update, :update_status]

  def index
    @tasks = @project.tasks
  end  

  def create
    @task = @project.tasks.build(task_params)
    if @task.save
      redirect_to @project, notice: 'Task was successfully created.'
    else
      render 'projects/show'
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @project, notice: 'Task was successfully updated.'
    else
      render 'projects/show'
    end
  end

  # New action for updating status via drag-and-drop
  def update_status
    @task= Task.find(params[:id])
    if @task.update(status: params[:status])
      render json: { success: true }
    else
      render json: { success: false ,errors: @task.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_task
    @task = @project.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :status)
  end
end

