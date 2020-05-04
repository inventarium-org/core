# frozen_string_literal: true

module Web
  module Views
    module Services
      class Show
        include Web::View

        def breadcrumb
          html do
            a('Services', href: "/#{organisation.slug}/services")
            text('>')
            span(service.name)
          end
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
