Hanami::Model.migration do
  change do
    create_table :environments do
      primary_key :id
      foreign_key :service_id, :services, on_delete: :cascade

      column :name, String, null: false
      column :description, String
      column :tags, :jsonb, default: '[]'

      column :url, String
      column :healthcheck_url, String
      column :logs_url, String
      column :error_traker_url, String
      column :monitoring, :jsonb, default: '{}'

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
