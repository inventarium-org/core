# frozen_string_literal: true

module Web
  module Controllers
    module Organisations
      class Show
        include Web::Action
        include Dry::Monads::Result::Mixin

        include Import[
          operation: 'organisations.operations.show',
          audit_operation: 'organisations.operations.audit',
          services_operation: 'services.operations.list'
        ]

        expose :organisation
        expose :services
        expose :last_changes

        def call(params)
          result = operation.call(account_id: current_account.id, slug: params[:slug])

          case result
          when Success
            @organisation = result.value!
            @services = services_operation.call(organisation_id: @organisation.id).value_or([])
            @last_changes = audit_operation.call(organisation_id: @organisation.id, limit: 10).value_or([])
          when Failure
            redirect_to routes.root_path
          end
        end
      end
    end
  end
end
