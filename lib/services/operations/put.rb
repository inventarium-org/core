# frozen_string_literal: true

module Services
  module Operations
    class Put < ::Libs::Operation
      include Import[
        mapper: 'services.mappers.service_information',
        repo: 'repositories.service'
      ]

      def call(organisation:, params:)
        # TODO: implement validation logic here too
        payload = mapper.call(params)
        payload[:organisation_id] = organisation.id

        persist(organisation, payload)
      end

    private

      def persist(organisation, payload)
        Success(repo.create_or_upate(organisation.id, payload))
      rescue Hanami::Model::UniqueConstraintViolationError, Hanami::Model::NotNullConstraintViolationError
        Failure(:invalid_data)
      end
    end
  end
end
