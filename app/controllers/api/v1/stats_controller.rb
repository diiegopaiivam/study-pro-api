module Api
  module V1
    class StatsController < BaseController
      def show
        subjects = current_user.subjects.includes(themes: :study_sessions)
        sessions = subjects.flat_map { |s| s.themes.flat_map(&:study_sessions) }

        total_questions = sessions.sum(&:total)
        total_correct   = sessions.sum(&:correct)
        total_wrong     = sessions.sum(&:wrong)
        average_pct     = sessions.any? ? (sessions.sum(&:percentage).to_f / sessions.size).round : 0

        render json: {
          total_questions: total_questions,
          total_correct: total_correct,
          total_wrong: total_wrong,
          average_percentage: average_pct,
          total_sessions: sessions.size,
          subjects_count: subjects.size,
          themes_count: subjects.sum { |s| s.themes.size }
        }
      end
    end
  end
end
