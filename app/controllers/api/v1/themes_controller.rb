module Api
  module V1
    class ThemesController < BaseController
      before_action :set_subject

      def index
        themes = @subject.themes.includes(:study_sessions)
        render json: themes.map { |t| serialize_theme(t) }
      end

      def create
        theme = @subject.themes.build(theme_params)
        if theme.save
          render json: serialize_theme(theme), status: :created
        else
          render_error(theme.errors.full_messages.join(", "))
        end
      end

      def destroy
        theme = @subject.themes.find(params[:id])
        theme.destroy
        head :no_content
      rescue ActiveRecord::RecordNotFound
        render_error("Theme not found", status: :not_found)
      end

      private

      def set_subject
        @subject = current_user.subjects.find(params[:subject_id])
      rescue ActiveRecord::RecordNotFound
        render_error("Subject not found", status: :not_found)
      end

      def theme_params
        params.require(:theme).permit(:name)
      end

      def serialize_theme(theme)
        {
          id: theme.id,
          subject_id: theme.subject_id,
          name: theme.name,
          created_at: theme.created_at,
          sessions: theme.study_sessions.map { |s| serialize_session(s) }
        }
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
