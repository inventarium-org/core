# frozen_string_literal: true

module Web
  module Views
    module Dashboard
      class Index
        include Web::View

        def organisation
          Organisation.new
        end

        def organisations_active_class
          'active'
        end
      end
    end
  end
end
