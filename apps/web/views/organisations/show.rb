# frozen_string_literal: true

module Web
  module Views
    module Organisations
      class Show
        include Web::View

        def dashboard_active_class
          'active'
        end

        def breadcrumb
          html.nav('aria-label' => 'breadcrumb') do
            ol(class: 'breadcrumb') do
              li(class: 'breadcrumb-item', 'aria-current' => 'page') { 'Dashboard' }
            end
          end
        end
      end
    end
  end
end
