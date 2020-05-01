# frozen_string_literal: true

module Organisations
  module Operations
    class Create < ::Libs::Operation
      include Import[
        'organisations.libs.token_generator',
        repo: 'repositories.organisation'
      ]

      def call(account_id:, name:)
        return Failure(:invalid_name) if name.to_s.empty?

        token = token_generator.call
        slug = name.to_s.tr(' ', '-').downcase

        persist(account_id, name, slug, token)
      end

    private

      def persist(account_id, name, slug, token)
        Success(
          repo.create_for_account(account_id, name, slug, token)
        )
      rescue Hanami::Model::UniqueConstraintViolationError, Hanami::Model::NotNullConstraintViolationError
        Failure(:invalid_payload)
      end
    end
  end
end
