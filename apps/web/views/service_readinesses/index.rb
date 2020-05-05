module Web
  module Views
    module ServiceReadinesses
      class Index
        include Web::View

        def breadcrumb
          html do
            a('Services', href: "/#{organisation.slug}/services")
            text('>')
            a(service.name, href: "/#{organisation.slug}/services/#{service.key}")
            text('>')
            span('Production Checklist')
          end
        end

        def services_active_class
          'active'
        end

        def card_style(status)
          status ? 'text-success' : 'text-danger'
        end
      end
    end
  end
end
