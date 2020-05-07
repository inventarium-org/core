# frozen_string_literal: true

module Web
  module Views
    module OrganisationQualityAttributes
      class Index
        include Web::View

        def quality_attributes_active_class
          'active'
        end

        def breadcrumb
          html.nav('aria-label' => 'breadcrumb') do
            ol(class: 'breadcrumb') do
              li(class: 'breadcrumb-item', 'aria-current' => 'page') { 'Quality Attributes' }
            end
          end
        end

        def service_map(services)
          map = {}

          services.each do |service|
            map[service.classification] ||= {}
            map[service.classification][service.status] ||= []
            map[service.classification][service.status] << service
          end

          map
        end

        def link_to_service(service)
          link_to service.name, "/#{organisation.slug}/services/#{service.key}"
        end
      end
    end
  end
end
