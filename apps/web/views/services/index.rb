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
          link_to service, "/#{organisation.slug}/services/#{service}"
        end

        def readinessbar(service)
          completed_checks_count = service.readiness.completed_checks_count
          percent = (completed_checks_count / READINESS_CHECKS_COUNT.to_f) * 100.0

          html.div(class: 'row') do
            div(class: 'col-8') do
              div(class: 'progress') do
                div(
                  class: 'progress-bar bg-success',
                  'aria-valuemax': '100',
                  'aria-valuemin': '0',
                  'aria-valuenow': '100',
                  role: 'progressbar',
                  style: "width: #{percent}%"
                )
              end
            end

            div(class: 'col-4') do
              span { "#{completed_checks_count} / #{READINESS_CHECKS_COUNT}" }
            end
          end
        end
      end
    end
  end
end
