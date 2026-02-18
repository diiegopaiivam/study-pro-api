module Api
  module V1
    class MeController < BaseController
      
      def show
        render json: {
          id: current_user.id,
          full_name: current_user.name,
          email: current_user.email,
          created_at: current_user.created_at
        }
      end
    end
  end
end
