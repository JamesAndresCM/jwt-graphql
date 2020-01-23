module Api
  module V1
    class HomeController < ApplicationController
      def index
        render json: { status: 200, msg: "You are currently Logged-in as #{current_user.name}" }
      end
    end
  end
end
