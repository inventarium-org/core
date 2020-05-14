module Web
  module Controllers
    module OrganisationMaps
      class Index
        include Web::Action
        include Dry::Monads::Result::Mixin

        include Import[
          all_communications: 'services.operations.all_communications',
          organisation_operation: 'organisations.operations.show',
        ]

        expose :organisation, :communications

        def call(params)
          result = organisation_operation.call(account_id: current_account.id, slug: params[:slug])

          case result
          when Success
            @organisation = result.value!
            @communications = all_communications.call(organisation_id: @organisation.id).value_or([])
          when Failure
            redirect_to routes.root_path
          end
        end
      end
    end
  end
end
