# frozen_string_literal: true

module Web
  module Views
    module Static
      class Index
        include Web::View

        def title
          'index'
        end
        def seo_meta_information
          {
            title: '',
            description: '',
            url: '',
            image: ''
          }
        end
      end
    end
  end
end
