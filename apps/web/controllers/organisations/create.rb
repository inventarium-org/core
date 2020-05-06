# frozen_string_literal: true

module Web
  module Controllers
    module Organisations
      class Create
        include Web::Action
        include Dry::Monads::Result::Mixin

        include Import[
          operation: 'organisations.operations.create'
        ]

        def call(params)
          result = operation.call(**params[:organisation])

          case result
          when Success
            redirect_to routes.root_path
          when Failure
            redirect_to routes.new_organisation_path
            # TODO: show error message here
          end
        end
      end
    end
  end
end
