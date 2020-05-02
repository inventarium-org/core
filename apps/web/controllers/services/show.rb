# frozen_string_literal: true

module Web
  module Controllers
    module Services
      class Show
        include Web::Action
        include Dry::Monads::Result::Mixin
        include Dry::Monads::Do.for(:logic_pipe)

        include Import[
          operation: 'services.operations.list',
          organisation_operation: 'organisations.operations.show'
        ]

        expose :organisation, :service

        def call(params)
          result = logic_pipe(params)

          case result
          when Success
            @organisation = result.value![:organisation]
            @service = result.value![:service]
          when Failure
            redirect_to routes.root_path
          end
        end

        private

        def logic_pipe(params)
          organisation = yield organisation_operation.call(account_id: current_account.id, slug: params[:slug])
          service = yield operation.call(organisation_id: organisation.id)

          Success({
                    organisation: organisation,
                    service: service
                  })
        end
      end
    end
  end
end
