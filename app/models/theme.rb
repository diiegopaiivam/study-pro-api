class Theme < ApplicationRecord
    belongs_to :subject
    has_many :study_sessions, dependent: :destroy
  
    validates :name, presence: true
  
    delegate :user, to: :subject
  end