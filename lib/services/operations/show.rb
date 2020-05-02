# frozen_string_literal: true

module Services
  module Operations
    class Show < ::Libs::Operation
      include Import[
      ]

      def call()
        Success(true)
      end
    end
  end
end
