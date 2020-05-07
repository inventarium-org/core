# frozen_string_literal: true

module Web
  module Views
    module OrganisationSettings
      class Index
        include Web::View

        def settings_active_class
          'active'
        end

        def breadcrumb
          html.nav('aria-label' => 'breadcrumb') do
            ol(class: 'breadcrumb') do
              li(class: 'breadcrumb-item', 'aria-current' => 'page') { 'Settings' }
            end
          end
        end
      end
    end
  end
end
