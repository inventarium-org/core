module Web
  module Views
    module ServiceReadinesses
      class Index
        include Web::View

        def breadcrumb
          html.nav('aria-label' => "breadcrumb") do
            ol(class: "breadcrumb") do
              li(class: "breadcrumb-item") do
                a('Services', href: "/#{organisation.slug}/services")
              end
              li(class: "breadcrumb-item") do
                a(service.name, href: "/#{organisation.slug}/services/#{service.key}")
              end
              li(class: "breadcrumb-item", 'aria-current' => "page") { 'Production Checklist' }
            end
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
