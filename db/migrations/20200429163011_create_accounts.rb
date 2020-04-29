# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :accounts do
      primary_key :id

      column :uuid,       String
      column :name,       String
      column :email,      String
      column :avatar_url, String

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
