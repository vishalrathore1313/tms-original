class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy

  has_many_attached :files

  has_paper_trail
end
