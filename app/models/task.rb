class Task < ApplicationRecord
  belongs_to :project

  enum status: { backlog: 'Backlog', in__progress: 'In_progress', completed: 'Completed'}

  after_initialize :set_default_status,if: :new_record?

  private

  def set_default_status

    self.status ||= :backlog

  end  
end
