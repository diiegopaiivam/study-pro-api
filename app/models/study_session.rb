class StudySession < ApplicationRecord
    belongs_to :theme
  
    validates :correct, :wrong, numericality: { greater_than_or_equal_to: 0 }
  
    before_validation :compute_totals
  
    private
  
    def compute_totals
      self.total = (correct || 0) + (wrong || 0)
      self.percentage = total > 0 ? ((correct.to_f / total) * 100).round : 0
    end
end