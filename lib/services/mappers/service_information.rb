# frozen_string_literal: true

require 'json'

module Services
  module Mappers
    class ServiceInformation
      def call(params) # rubocop:disable Metrics/AbcSize
        return {} if params.empty?

        payload = symbolize_keys(params)
        {
          version: payload[:version].downcase,

          key: payload[:key],
          name: payload[:name],

          description: payload[:description],
          languages: Array(payload[:languages]),
          repository_link: payload[:repository_link],

          tags: Array(payload[:tags]),

          owner_name: payload.dig(:owner, :team_or_developer_name),
          owner_slack_channel: payload.dig(:owner, :slack_channel),

          classification: payload.dig(:service, :classification),
          status: payload.dig(:service, :status),

          ci_build_url: payload.dig(:operations, :ci_build_url),

          docs_api: payload.dig(:docs, :api),
          docs_maintenance: payload.dig(:docs, :maintenance),
          docs_domain: payload.dig(:docs, :domain),

          environments: payload[:environments].to_a.map { |name, data| { name: name.to_s, **data } }
        }
      end

      private

      def symbolize_keys(payload)
        JSON.parse(JSON.generate(payload), symbolize_names: true)
      end
    end
  end
end
