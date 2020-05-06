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

        def readiness_card(title, status, description)
          collapse_id = "#{title.tr(' ', '').downcase}Collapse"
          icon_class = status ? 'nc-icon nc-check-2' : 'nc-icon nc-simple-remove'

          html.div(class: 'quality-attribute card') do
            div(class: 'card-header') do
              a(class: "#{card_style(status)} attribute-content", 'aria-controls' => collapse_id, 'aria-expanded' => "false", 'data-toggle' => "collapse", :href => "##{collapse_id}", role: "button") do
                div do
                  i(class: icon_class)
                  text(title)
                end
                div(class: 'down-icon') do
                  i(class: 'nc-icon nc-minimal-down')
                end
              end
            end

            div(id: collapse_id, class: 'collapse') do
              div(class: 'card-body') do
                p(class: 'card-text') { description }
              end
            end
          end
        end
      end
    end
  end
end
