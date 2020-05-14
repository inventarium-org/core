# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :communications do
      primary_key :id
      foreign_key :service_id, :services, on_delete: :cascade

      column :type, String, null: false
      column :target, String, null: false
      column :criticality, String, null: false

      column :resources, :jsonb, default: '[]'
      column :custom_data, :jsonb, default: '{}'

      column :deleted, TrueClass, default: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
