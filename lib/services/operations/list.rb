# frozen_string_literal: true

module Services
  module Operations
    class List < ::Libs::Operation
      include Import[
      ]

      def call(organisation_id:)
        Success(true)
      end
    end
  end
end
