# frozen_string_literal: true

module Web
  module Controllers
    module Services
      class Index
        include Web::Action
        include Dry::Monads::Result::Mixin

        include Import[
          operation: 'services.operations.list',
          organisation_operation: 'organisations.operations.show'
        ]

        expose :organisation
        expose :services

        def call(params)
          result = organisation_operation.call(account_id: current_account.id, slug: params[:slug])

          case result
          when Success
            @organisation = result.value!
            @services = operation.call(organisation_id: @organisation.id).value_or([])
          when Failure
            redirect_to routes.root_path
          end
        end
      end
    end
  end
end
