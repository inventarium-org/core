# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :organisation_audit_items do
      primary_key :id
      foreign_key :organisation_id, :organisations, on_delete: :cascade

      column :service_key, String
      column :payload, :jsonb, default: '{}'

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
