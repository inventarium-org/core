# frozen_string_literal: true

module Auth
  module Controllers
    module OauthSession
      class Create
        include Auth::Action
        include Dry::Monads::Result::Mixin

        include Import[
          operation: 'accounts.operations.create_by_oauth'
        ]

        def call(params) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
          result = operation.call(
            provider: params[:provider].to_s,
            payload: request.env['omniauth.auth']
          )

          case result
          when Success
            # TODO: send something for new login
            session[:account] = result.value!
            redirect_to routes.root_path
          when Failure
            redirect_to routes.login_path
            # TODO: log that account has a trouble with login
          end
        end
      end
    end
  end
end
