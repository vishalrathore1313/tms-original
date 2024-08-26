
class TasksController < ApplicationController
  before_action :set_project

  def index
    #  @project = Project.find(params[:project_id])
     @task = @project.tasks
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
    @task = @project.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to @project, notice: 'Task was successfully updated.'
    else
      render 'projects/show'
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def task_params
    params.require(:task).permit(:title,:description,:status)
  end
end


