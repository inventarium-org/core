# frozen_string_literal: true

module Accounts
  module Operations
    class CreateByOauth < ::Libs::Operation
      include Import[
        repo: 'repositories.account'
      ]

      def call(provider:, payload:)
        account = repo.find_by_auth_identity(provider, auth_identity_params(payload))

        if account.nil?
          account = yield persist(provider, payload)

          # TODO: send something for new created account
        end

        Success(account)
      end

    private

      def persist(provider, payload)
        Success(
          repo.create_with_identity(
            Core::Types::AuthIdentityProvider[provider],
            account_params(payload),
            auth_identity_params(payload)
          )
        )
      rescue Dry::Types::ConstraintError
        Failure(:invalid_provider)
      rescue Hanami::Model::UniqueConstraintViolationError, Hanami::Model::NotNullConstraintViolationError
        Failure(:invalid_payload)
      end

      def account_params(payload)
        {
          uuid: SecureRandom.uuid,
          name: payload['extra']['raw_info']['name'],
          email: payload['extra']['raw_info']['email'],
          avatar_url: payload['extra']['raw_info']['avatar_url'],
        }
      end

      def auth_identity_params(payload)
        {
          uid: payload['uid'],
          login: payload['extra']['raw_info']['login'],
          token: payload['credentials']['token'],
          email: payload['extra']['raw_info']['email'],
        }
      end
    end
  end
end
