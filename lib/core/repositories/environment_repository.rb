class EnvironmentRepository < Hanami::Repository
  associations do
    belongs_to :service
  end
end
