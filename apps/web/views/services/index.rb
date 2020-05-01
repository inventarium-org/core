module Web
  module Views
    module Services
      class Index
        include Web::View

        def services_active_class
          'active'
        end
      end
    end
  end
end
