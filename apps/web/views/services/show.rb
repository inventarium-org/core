# frozen_string_literal: true

module Web
  module Views
    module Services
      class Show
        include Web::View

        def breadcrumb
          html.nav('aria-label' => 'breadcrumb') do
            ol(class: 'breadcrumb') do
              li(class: 'breadcrumb-item') do
                a('Services', href: "/#{organisation.slug}/services")
              end
              li(class: 'breadcrumb-item', 'aria-current' => 'page') { service.name }
            end
          end
        end

        def services_active_class
          'active'
        end

        def service_show_active
          'active'
        end

        def service_readiness_active; end

        def service_quality_active; end

        def service_audit_active; end

        def service_information(key, value)
          html.div(class: 'row service-information') do
            div(class: 'col title') { key }
            div(class: 'col value') do
              if key == 'Tags'
                value.map { |tag| span(tag, class: 'badge badge-primary') }
              else
                value || 'Empty'
              end
            end
          end
        end

        def service_information_link(key, value)
          html.div(class: 'row service-information') do
            div(class: 'col title') { key }
            div(class: 'col value') do
              if value
                link_to URI(value).host, value
              else
                'Empty'
              end
            end
          end
        end
      end
    end
  end
end
