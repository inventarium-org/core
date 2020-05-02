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
            span('Service name')
          end
        end
      end
    end
  end
end
