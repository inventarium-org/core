# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :readinesses do
      primary_key :id
      foreign_key :service_id, :services, on_delete: :cascade

      column :owner, TrueClass, default: false
      column :slack, TrueClass, default: false
      column :healthcheck, TrueClass, default: false
      column :logs, TrueClass, default: false
      column :error_traker, TrueClass, default: false
      column :continuous_integration, TrueClass, default: false
      column :api_documentation, TrueClass, default: false
      column :maintenance_documentation, TrueClass, default: false
      column :monitoring, TrueClass, default: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
