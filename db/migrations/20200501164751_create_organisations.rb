Hanami::Model.migration do
  change do
    create_table :organisations do
      primary_key :id

      column :name, String, null: false, unique: true
      column :slug, String, null: false, unique: true

      column :token, String, null: false, unique: true

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
