module Api
  module V1
    class SubjectsController < BaseController
      before_action :set_subject, only: [:show, :update, :destroy]

      def index
        subjects = current_user.subjects.includes(themes: :study_sessions)
        render json: subjects.map { |s| serialize_subject(s) }
      end

      def show
        render json: serialize_subject(@subject)
      end

      def create
        subject = current_user.subjects.build(subject_params)
        if subject.save
          render json: serialize_subject(subject), status: :created
        else
          render_error(subject.errors.full_messages.join(", "))
        end
      end

      def update
        if @subject.update(subject_params)
          render json: serialize_subject(@subject)
        else
          render_error(@subject.errors.full_messages.join(", "))
        end
      end

      def destroy
        @subject.destroy
        head :no_content
      end

      private

      def set_subject
        @subject = current_user.subjects.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render_error("Subject not found", status: :not_found)
      end

      def subject_params
        params.require(:subject).permit(:name, :color)
      end

      def serialize_subject(subject)
        {
          id: subject.id,
          name: subject.name,
          color: subject.color,
          created_at: subject.created_at,
          themes: subject.themes.map { |t| serialize_theme(t) }
        }
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
