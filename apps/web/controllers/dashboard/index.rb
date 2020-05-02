# frozen_string_literal: true

module Web
  module Controllers
    module Dashboard
      class Index
        include Web::Action
        include Dry::Monads::Result::Mixin

        include Import[
          operation: 'organisations.operations.list'
        ]

        expose :organisations

        def call(_params)
          current_account.id
          result = operation.call(account_id: current_account.id)

          case result
          when Success
            @organisations = result.value!
          when Failure
            # TODO: have no idea what to do here
            # redirect_to routes.root_path
          end
        end
      end
    end
  end
end
