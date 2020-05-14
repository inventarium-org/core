# frozen_string_literal: true

module Services
  module Schemas
    ServiceYaml = Dry::Validation.JSON do # rubocop:disable Metrics/BlockLength
      required(:version).filled(:str?)
      required(:name).filled(:str?)
      required(:key).filled(:str?)

      optional(:description).maybe(:str?)
      optional(:repository_link).maybe(:str?)

      optional(:languages).maybe(:array?)
      optional(:tags).maybe(:array?)

      optional(:classification).value(::Core::Types::ServiceClassification)
      optional(:status).value(::Core::Types::ServiceStatus)

      optional(:owner_name).maybe(:str?)
      optional(:owner_slack_channel).maybe(:str?)

      optional(:ci_build_url).maybe(:str?)

      optional(:docs_api).maybe(:str?)
      optional(:docs_maintenance).maybe(:str?)
      optional(:docs_domain).maybe(:str?)

      optional(:environments).each do
        required(:name).filled(:str?)
        optional(:description).maybe(:str?)

        optional(:url).maybe(:str?)
        optional(:healthcheck_url).maybe(:str?)
        optional(:error_tracker_url).maybe(:str?)

        optional(:monitoring).required(:hash?)

        optional(:tags).maybe(:array?)
      end

      optional(:communications).each do
        required(:type).filled(:str?)
        required(:target).filled(:str?)

        optional(:criticality).maybe(:str?)
        optional(:resources).maybe(:array?)
        optional(:custom_data).required(:hash?)
      end
    end
  end
end
