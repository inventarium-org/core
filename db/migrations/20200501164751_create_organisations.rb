# frozen_string_literal: true

Hanami::Model.migration do
  change do
    extension :pg_enum

    create_enum(:organisation_plans, %w[demo free pro ent])

    create_table :organisations do
      primary_key :id

      column :name, String, null: false, unique: true
      column :slug, String, null: false, unique: true

      column :token, String, null: false, unique: true
      column :plan, 'organisation_plans', null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
