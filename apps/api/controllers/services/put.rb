module Api
  module Controllers
    module Services
      class Put
        include Api::Action

        def call(params)
          self.body = 'OK'
        end
      end
    end
  end
end
