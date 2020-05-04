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
      end
    end
  end
end
