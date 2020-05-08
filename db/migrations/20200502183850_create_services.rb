# frozen_string_literal: true

Hanami::Model.migration do
  change do
    extension :pg_enum

    create_enum(:service_classification, %w[critical normal internal expiriment])
    create_enum(:service_status, %w[adopt hold trial in_development])

    create_table :services do
      primary_key :id
      foreign_key :organisation_id, :organisations, on_delete: :cascade

      column :version, String, null: false

      column :key,  String, null: false
      column :name, String, null: false
      column :description, String
      column :languages, :jsonb, default: '[]'
      column :repository_link, String
      column :tags, :jsonb, default: '[]'

      column :owner_name, String
      column :owner_slack_channel, String

      column :classification, 'service_classification'
      column :status, 'service_status'

      column :ci_build_url, String

      column :docs_api, String
      column :docs_maintenance, String
      column :docs_domain, String

      column :deleted, TrueClass, default: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
