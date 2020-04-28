# frozen_string_literal: true

module Api
  module Controllers
    module Projects
      class Index
        include Api::Action

        def call(_params)
          self.body = '[]'
        end
      end
    end
  end
end
