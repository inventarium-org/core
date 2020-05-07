# frozen_string_literal: true

module Web
  module Views
    module Services
      class Index
        include Web::View

        READINESS_CHECKS_COUNT = Readiness::CHECK_NAMES.count

        def breadcrumb
          html.nav('aria-label' => 'breadcrumb') do
            ol(class: 'breadcrumb') do
              li(class: 'breadcrumb-item', 'aria-current' => 'page') { 'Services' }
            end
          end
        end

        def services_active_class
          'active'
        end

        def link_to_service(service)
          link_to service, "/#{organisation.slug}/services/#{service}", class: 'service-title'
        end

        def readinessbar(service)
          completed_checks_count = service.readiness ? service.readiness.completed_checks_count : 0
          percent = (completed_checks_count / READINESS_CHECKS_COUNT.to_f) * 100.0

          progress_bar_color = percent == 100 ? 'bg-success' : ''

          html.div(class: 'row') do
            div(class: 'col-8') do
              div(class: 'progress') do
                div(
                  class: "progress-bar #{progress_bar_color}",
                  'aria-valuemax': '100',
                  'aria-valuemin': '0',
                  'aria-valuenow': '100',
                  role: 'progressbar',
                  style: "width: #{percent}%"
                )
              end
            end

            div(class: 'col-4') do
              link_to "#{completed_checks_count} / #{READINESS_CHECKS_COUNT} (?)", "/#{organisation.slug}/services/#{service.key}/readiness"
            end
          end
        end
      end
    end
  end
end
