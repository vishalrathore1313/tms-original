class TasksController < ApplicationController

  load_and_authorize_resource

  before_action :set_project, only: [:index, :show, :create, :update, :destroy, :update_status]
  before_action :set_task, only: [:show, :update, :update_status, :destroy]

  def index
    @tasks = @project.tasks
  end

  def show
    @task = @project.tasks.find(params[:id])
  end  

  def create
    @task = @project.tasks.build(task_params)
    if @task.save
      redirect_to @project, notice: 'Task was successfully created.'
    else
      flash[:alert] = 'Error while creating task.'
      render 'projects/show'
    end
  end

  
  def destroy
    @task = @project.tasks.find(params[:id])
    @task.destroy
  
    redirect_to project_tasks_path(@project), notice: 'Task was successfully deleted.'
  end

  def update

    authorize! :update, @task

    if @task.update(task_params)
      redirect_to @project, notice: 'Task was successfully updated.'
    else
      render 'projects/show'
    end
  end

  def update_status
   

    authorize! :update, @task

    if @task.update(status: params[:status])
      render json: { success: true }
    else
      render json: { success: false, errors: @task.errors.full_messages }, status: :unprocessable_entity
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
    params.require(:task).permit(:title, :description, :status, :dependent_task_id)
  end
end
