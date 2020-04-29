# frozen_string_literal: true

module Auth
  module Controllers
    module Oauth
      class Show
        include Auth::Action

        def call(params)
          params[:provider]
          redirect_to routes.login_path
        end
      end
    end
  end
end
