# frozen_string_literal: true

module Web
  module Views
    module OrganisationSettings
      class Index
        include Web::View

        def settings_active_class
          'active'
        end
      end
    end
  end
end
