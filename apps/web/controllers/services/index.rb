module Web
  module Controllers
    module Services
      class Index
        include Web::Action
        include Dry::Monads::Result::Mixin

        include Import[
          operation: 'organisations.operations.show'
        ]

        expose :organisation

        def call(params) # rubocop:disable Metrics/MethodLength
          current_account.id
          result = operation.call(account_id: current_account.id, slug: params[:slug])

          case result
          when Success
            @organisation = result.value!
          when Failure
            redirect_to routes.root_path
          end
        end
      end
    end
  end
end
