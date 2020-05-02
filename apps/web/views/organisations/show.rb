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
          'Dashboard'
        end
      end
    end
  end
end
