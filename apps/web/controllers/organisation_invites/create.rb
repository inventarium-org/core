# frozen_string_literal: true

module Web
  module Controllers
    module OrganisationInvites
      class Create
        include Web::Action
        include Dry::Monads::Result::Mixin
        include Dry::Monads::Do.for(:invite)

        include Import[
          operation: 'organisations.operations.show',
          invite_operation: 'accounts.operations.invite'
        ]

        def call(params)
          result = invite(params)

          case result
          when Success
            flash[:success] = 'User was invited'
          when Failure
            flash[:fail] = "User can't be inited"
          end

          redirect_to routes.organisation_settings_path(params[:slug])
        end

        def invite(params)
          organisation = yield operation.call(account_id: current_account.id, slug: params[:slug])
          invite_operation.call(organisation_id: organisation.id, payload: params[:invite])
        end
      end
    end
  end
end
