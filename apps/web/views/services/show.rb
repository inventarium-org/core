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

        def service_information(key, value)
          html.div(class: 'row') do
            div(class: 'col') { key }
            div(class: 'col') { value || 'Empty' }
          end
        end

        def service_information_link(key, value)
          html.div(class: 'row') do
            div(class: 'col') { key }
            div(class: 'col') do
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
