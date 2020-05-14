module Web
  module Views
    module OrganisationMaps
      class Index
        include Web::View
        def map_of_services_active_class
          'active'
        end

        def breadcrumb
          html.nav('aria-label' => 'breadcrumb') do
            ol(class: 'breadcrumb') do
              li(class: 'breadcrumb-item', 'aria-current' => 'page') { 'Map of services' }
            end
          end
        end
      end
    end
  end
end
