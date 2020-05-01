# frozen_string_literal: true

module Web
  module Views
    module Dashboard
      class Index
        include Web::View

        def organisation
          Organisation.new(name: 'Will be removed', slug: 'inventarium-mvp')
        end
      end
    end
  end
end
