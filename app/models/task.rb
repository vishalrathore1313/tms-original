class Task < ApplicationRecord
  belongs_to :project

  belongs_to :dependent_task, class_name: 'Task', optional: true

  has_many :dependent_tasks, class_name: 'Task', foreign_key: 'dependent_task_id'

  validate :dependency_not_self 
  validate :dependencies_completed,on: :update

  enum status: { backlog: 'Backlog', in_progress: 'In_progress', completed: 'Completed'}

  after_initialize :set_default_status,if: :new_record?



  def completed?
    status == 'Completed'
  end

  private

  def set_default_status

    self.status ||= :backlog

  end  

  def dependency_not_self
    if dependent_task_id.present? && dependent_task_id == id
      errors.add(:dependent_task_id, "can't be dependent on itself")
    end
  end

  def dependencies_completed
    if dependent_task.present? && dependent_task.reload.status != 'completed' && status_changed?

      errors.add(:status, 'cannot be changed until dependent task is completed')
    end
  end


end



