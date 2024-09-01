class TasksController < ApplicationController
  load_and_authorize_resource

  before_action :set_project, only: [:index, :show, :create, :update, :destroy, :update_status]
  before_action :set_task, only: [:show, :update, :update_status, :destroy]
  before_action :authorize_user, only: %i[create update]

  def index
    @tasks = @project.tasks
  end

  def show
  end  

  def create
    @task = @project.tasks.build(task_params)
    @task.assigned_by = current_user.id 
    
    if @task.save
      notify_assignment(@task) if @task.assigned_to.present?
      redirect_to @project, notice: 'Task was successfully created.'
    else
      flash[:alert] = 'Error while creating task.'
      render 'projects/show'
    end
  end
  
  def destroy
    @task.destroy
    redirect_to project_tasks_path(@project), notice: 'Task was successfully deleted.'
  end

  def update
    authorize! :update, @task

    if @task.update(task_params)
      notify_assignment(@task) if task_params[:assigned_to].present?
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
    @task = Task.find(params[:id])
    @project = @task.project
  end
  

  def task_params
    params.require(:task).permit(:title, :description, :status, :assigned_to, :dependent_task_id)
  end
  

  def authorize_user
    return if current_user.admin? || (current_user.manager? && params[:action] == 'update')

    if params[:task][:assigned_to].present? && cannot?(:assign, Task)
      redirect_to tasks_path, alert: 'You are not authorized to assign this task.'
    end
  end

  def notify_assignment(task)
    assigned_user = User.find(task.assigned_to)
    UserMailer.task_assignment_notification(task, assigned_user).deliver_now
  end
end
