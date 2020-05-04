# frozen_string_literal: true

module Api
  module Controllers
    module Services
      class Put
        include Api::Action

        def call(params)
          params[:token]
          params[:service]
          self.body = 'OK'
        end
      end
    end
  end
end
