# frozen_string_literal: true

module Web
  module Views
    module ServiceAudit
      class Index
        include Web::View

        def breadcrumb
          html.nav('aria-label' => 'breadcrumb') do
            ol(class: 'breadcrumb') do
              li(class: 'breadcrumb-item') do
                a('Services', href: "/#{organisation.slug}/services")
              end
              li(class: 'breadcrumb-item') do
                a(service.name, href: "/#{organisation.slug}/services/#{service.key}")
              end
              li(class: 'breadcrumb-item', 'aria-current' => 'page') { 'Audit log' }
            end
          end
        end

        def services_active_class
          'active'
        end

        def service_show_active; end

        def service_readiness_active; end

        def service_quality_active; end

        def service_audit_active
          'active'
        end
      end
    end
  end
end
