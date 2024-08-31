class ProjectsController < ApplicationController
  def index
    @projects = Project.all
    @project= Project.new
  end

  def show
    @project = Project.find(params[:id])
    @tasks = @project.tasks
    @task = @project.tasks.build  #made change
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to @project, notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path, notice: 'Project was successfully deleted.'
  end
  

  # def revert
    # @project = Project.find(params[:id])
  #   @version = @project.versions.find(params[:version_id])
  #   @version.reify.save! # Revert to the selected version
  #   redirect_to projects_path, notice: "Reverted to previous version."
  # end
  
  def revert
    @project = Project.find(params[:id])
    @version = @project.versions.find_by(id: params[:version_id])
  
    if @version.present? && @version.reify.present?
      @version.reify.save! # Revert to the selected version
      redirect_to projects_path, notice: "Reverted to previous version."
    else
      redirect_to projects_path, alert: "Unable to revert to the selected version."
    end
  end
  

  def audit_log
    # @project = Project.find(params[:id])
    @versions = PaperTrail::Version.order(created_at: :desc)
  end
  


  private

  def project_params
    params.require(:project).permit(:title,files: [])
  end
end




