# frozen_string_literal: true

module Services
  module Operations
    class Show < ::Libs::Operation
      include Import[
      ]

      def call(organisation_id:)
        Success(Service.new(id: 1))
      end
    end
  end
end
