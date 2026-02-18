class Subject < ApplicationRecord
    belongs_to :user
    has_many :themes, dependent: :destroy
  
    validates :name, presence: true
end