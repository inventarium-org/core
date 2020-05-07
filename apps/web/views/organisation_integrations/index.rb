# frozen_string_literal: true

module Web
  module Views
    module OrganisationIntegrations
      class Index
        include Web::View

        def integrations_active_class
          'active'
        end

        def breadcrumb
          html.nav('aria-label' => 'breadcrumb') do
            ol(class: 'breadcrumb') do
              li(class: 'breadcrumb-item', 'aria-current' => 'page') { 'Integrations' }
            end
          end
        end
      end
    end
  end
end
