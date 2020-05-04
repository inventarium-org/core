module Web
  module Controllers
    module ServiceReadinesses
      class Index
        include Web::Action
        include Dry::Monads::Result::Mixin
        include Dry::Monads::Do.for(:logic_pipe)

        include Import[
          operation: 'services.operations.show',
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
            redirect_to routes.path(':slug_service'.to_sym, params[:slug], params[:service_id])
          end
        end

        private

        def logic_pipe(params)
          organisation = yield organisation_operation.call(account_id: current_account.id, slug: params[:slug])
          service = yield operation.call(organisation_id: organisation.id, key: params[:service_id])

          Success({
                    organisation: organisation,
                    service: service
                  })
        end
      end
    end
  end
end
