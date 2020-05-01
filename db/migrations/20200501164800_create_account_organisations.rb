Hanami::Model.migration do
  change do
    extension :pg_enum

    create_enum(:account_organisation_roles, %w[owner participator])

    create_table :account_organisations do
      primary_key :id

      foreign_key :account_id, :accounts, on_delete: :cascade
      foreign_key :organisation_id, :organisations, on_delete: :cascade

      column :role, 'account_organisation_roles', null: false, default: 'participator'

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
