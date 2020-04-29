# frozen_string_literal: true

module Auth
  module Controllers
    module OauthSession
      class Create
        include Auth::Action

        def call(params)
          params[:provider]
          request.env['omniauth.auth']
          redirect_to routes.login_path
        end

        private

        def oauth_params
          request.env['omniauth.auth']
        end
      end
    end
  end
end
