# frozen_string_literal: true

module Web
  module Views
    module ServiceReadinesses
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
              li(class: 'breadcrumb-item', 'aria-current' => 'page') { 'Production Checklist' }
            end
          end
        end

        def services_active_class
          'active'
        end

        def service_show_active; end

        def service_readiness_active
          'active'
        end

        def service_quality_active; end

        def service_audit_active; end

        def card_style(status)
          status ? 'text-success' : 'text-danger'
        end

        def readiness_card(title, status, description)
          icon_class = status ? 'nc-icon nc-check-2' : 'nc-icon nc-simple-remove'

          html.div(class: 'quality-attribute card') do
            div(class: 'card-header') do
              div(class: 'row') do
                div(class: "col-3 #{card_style(status)}") do
                  i(class: icon_class)
                  text(title)
                end

                div(class: 'col-9 card-header-description') { description }
              end
            end
          end
        end
      end
    end
  end
end
