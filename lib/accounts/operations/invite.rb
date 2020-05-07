# frozen_string_literal: true

module Accounts
  module Operations
    class Invite < ::Libs::Operation
      include Import[
        repo: 'repositories.organisation_invite',
        account_organisation_repo: 'repositories.account_organisation'
      ]

      def call(organisation_id:, payload:)
        yield validate_inviter(organisation_id, payload[:inviter_id])

        persist(organisation_id, payload)
      end

      private

      def validate_inviter(organisation_id, inviter_id)
        if account_organisation_repo.member?(organisation_id, inviter_id)
          Success(inviter_id)
        else
          Failure(:account_is_not_a_member_of_organisation)
        end
      end

      def persist(organisation_id, payload)
        if account_organisation_repo.invite_account(organisation_id, payload[:github_or_email])
          Success(:existed_member_invited)
        else
          Success(
            repo.create(
              organisation_id: organisation_id,
              inviter_id: payload[:inviter_id],
              github_or_email: payload[:github_or_email]
            )
          )
        end
      rescue Hanami::Model::UniqueConstraintViolationError, Hanami::Model::NotNullConstraintViolationError
        Failure(:invalid_data)
      end
    end
  end
end
