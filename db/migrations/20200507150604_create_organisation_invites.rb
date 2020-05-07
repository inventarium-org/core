# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :organisation_invites do
      primary_key :id
      foreign_key :organisation_id, :organisations, on_delete: :cascade

      column :inviter_id, Integer, null: false
      column :github_or_email, String, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
