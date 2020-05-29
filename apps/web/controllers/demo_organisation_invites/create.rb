# frozen_string_literal: true
#
module Web
  module Controllers
    module DemoOrganisationInvites
      class Create
        include Web::Action
        include Dry::Monads::Result::Mixin
        include Dry::Monads::Do.for(:invite)

        include Import[
          invite_operation: 'organisations.operations.invite_to_demo'
        ]

        def call(params)
          result = invite_operation.call(account_id: params[:invite][:account_id])

          case result
          when Success
            flash[:success] = 'User was invited to the demo organisation'
          when Failure
            flash[:fail] = "User can't be inited to the demo organisation"
          end

          redirect_to routes.root_path
        end
      end
    end
  end
end
