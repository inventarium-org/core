# frozen_string_literal: true

module Web
  module Views
    module OrganisationQualityAttributes
      class Index
        include Web::View

        def quality_attributes_active_class
          'active'
        end

        def breadcrumb
          html.nav('aria-label' => 'breadcrumb') do
            ol(class: 'breadcrumb') do
              li(class: 'breadcrumb-item', 'aria-current' => 'page') { 'Quality Attributes' }
            end
          end
        end
      end
    end
  end
end
