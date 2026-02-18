module Api
  module V1
    class StudySessionsController < BaseController
      before_action :set_theme

      def create
        session = @theme.study_sessions.build(session_params)
        if session.save
          render json: serialize_session(session), status: :created
        else
          render_error(session.errors.full_messages.join(", "))
        end
      end

      private

      def set_theme
        # Ensure the theme belongs to the current user
        @theme = Theme.joins(:subject).where(subjects: { user_id: current_user.id }).find(params[:theme_id])
      rescue ActiveRecord::RecordNotFound
        render_error("Theme not found", status: :not_found)
      end

      def session_params
        params.require(:study_session).permit(:correct, :wrong)
      end

      def serialize_session(session)
        {
          id: session.id,
          theme_id: session.theme_id,
          correct: session.correct,
          wrong: session.wrong,
          total: session.total,
          percentage: session.percentage,
          created_at: session.created_at
        }
      end
    end
  end
end
