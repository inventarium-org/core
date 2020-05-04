class ReadinessRepository < Hanami::Repository
  associations do
    belongs_to :service
  end
end
