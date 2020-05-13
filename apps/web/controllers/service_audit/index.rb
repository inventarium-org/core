# frozen_string_literal: true

module Web
  module Controllers
    module ServiceAudit
      class Index
        include Web::Action
        include Dry::Monads::Result::Mixin
        include Dry::Monads::Do.for(:logic_pipe)

        include Import[
          operation: 'services.operations.show',
          audit_operation: 'organisations.operations.audit',
          organisation_operation: 'organisations.operations.show'
        ]

        expose :organisation, :service, :last_changes

        def call(params)
          result = logic_pipe(params)

          case result
          when Success
            @organisation = result.value![:organisation]
            @service = result.value![:service]
            @last_changes = result.value![:last_changes]
          when Failure
            redirect_to "/#{params[:slug]}/services"
          end
        end

        private

        def logic_pipe(params)
          organisation = yield organisation_operation.call(account_id: current_account.id, slug: params[:slug])
          service = yield operation.call(organisation_id: organisation.id, key: params[:service_id])
          last_changes = yield audit_operation.call(organisation_id: organisation.id, key: params[:service_id])

          Success(
            {
              organisation: organisation,
              last_changes: last_changes,
              service: service
            }
          )
        end
      end
    end
  end
end
