module Web
  module Views
    module Organisations
      class New
        include Web::View

        def organisation
          Organisation.new
        end

        def new_organisation_active_class
          'active'
        end
      end
    end
  end
end
