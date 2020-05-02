# frozen_string_literal: true

module Web
  module Views
    module Services
      class Index
        include Web::View

        def breadcrumb
          'Services'
        end

        def services_active_class
          'active'
        end

        def link_to_service(service)
          link_to service, "/#{organisation.slug}/services/#{service}"
        end
      end
    end
  end
end
