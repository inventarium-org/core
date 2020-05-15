# frozen_string_literal: true

module Web
  module Views
    module OrganisationMaps
      class Index
        include Web::View
        def map_of_services_active_class
          'active'
        end

        def breadcrumb
          html.nav('aria-label' => 'breadcrumb') do
            ol(class: 'breadcrumb') do
              li(class: 'breadcrumb-item', 'aria-current' => 'page') { 'Map of services' }
            end
          end
        end

        def json_graph(communications)
          graph = {
            nodes: [],
            edges: []
          }

          communications.each do |communication|
            graph[:edges] << {
              source: communication.service.key,
              target: communication.target,
              label: communication.type,
              resources: communication.resources,
              criticality: communication.criticality,
              custom_data: communication.custom_data
            }

            graph[:nodes] << {
              id: communication.target,
              label: communication.target,
            }

            graph[:nodes] << {
              id: communication.service.key,
              label: communication.service.key,
            }
          end

          graph[:nodes] = graph[:nodes].uniq
          graph[:edges] = graph[:edges].uniq
          graph
        end
      end
    end
  end
end
