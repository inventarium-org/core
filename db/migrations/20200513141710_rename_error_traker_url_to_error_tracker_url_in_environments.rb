Hanami::Model.migration do
  change do
    alter_table :environments do
      rename_column :error_traker_url, :error_tracker_url
    end
  end
end
