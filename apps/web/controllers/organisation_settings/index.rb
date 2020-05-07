# frozen_string_literal: true

module Web
  module Controllers
    module OrganisationSettings
      class Index
        include Web::Action
        include Dry::Monads::Result::Mixin

        include Import[
          operation: 'organisations.operations.show',
          account_operation: 'accounts.operations.list'
        ]

        expose :organisation, :organisation_accounts

        def call(params)
          result = operation.call(account_id: current_account.id, slug: params[:slug])

          case result
          when Success
            @organisation = result.value!
            @organisation_accounts = account_operation.call(organisation_id: @organisation.id).value_or([])
          when Failure
            redirect_to routes.root_path
          end
        end
      end
    end
  end
end
