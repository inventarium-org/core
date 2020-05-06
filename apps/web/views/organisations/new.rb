module Web
  module Views
    module Organisations
      class New
        include Web::View

        def organisation
          Organisation.new
        end

        def new_organisation_active_class
          'active'
        end

        def form
          form_for :organisation, routes.organisations_path, method: :post, class: 'form-inline needs-validation', novalidate: true do
            text_field :account_id, type: 'hidden', value: current_account.id

            div(class: 'form-group mr-2') do
              text_field :name, placeholder: 'Organisation name', class: 'form-control', required: true
            end

            submit 'Create organisation', class: 'btn btn-success'
          end
        end
      end
    end
  end
end
