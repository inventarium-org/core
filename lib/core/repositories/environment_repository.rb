# frozen_string_literal: true

class EnvironmentRepository < Hanami::Repository
  associations do
    belongs_to :service
  end
end
